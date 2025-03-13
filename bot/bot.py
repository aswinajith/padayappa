import logging
from telegram import Update, InlineQueryResultArticle, InputTextMessageContent
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, filters, ContextTypes, InlineQueryHandler

from uuid import uuid4

logging.basicConfig(
        format="%(asctime)s - %(name)s -%(levelname)s - %(message)s",
        level=logging.INFO
        )

async def inline_caps(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.inline_query.query
    if not query: 
        return
    results = []
    result.append(
            InlineQueryResultArticle(
                id = str(uuid4()),
                title = 'Caps',
                input_message_content = InputTextMessageContent(query.upper())
                )
            )

async def awo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(
            chat_id=update.effective_chat.id, 
            text = "awo awo"
            )

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(
            chat_id=update.effective_chat.id,
            text="Hi, I am mookala pundachi"
            )

async def caps(update: Update, context: ContextTypes.DEFAULT_TYPE):
    text_caps = ' '.join(context.args).upper()
    await context.bot.send_message(chat_id=update.effective_chat.id,text = text_caps)

async def echo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id,
            text=update.message.text)

async def pundachi(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(
            chat_id = update.effective_chat.id,
            text="ninte appan thayoli pundachi"
            )

if __name__=='__main__':
    application = ApplicationBuilder().token('8086049144:AAHtq6_fyvCmN5_p3n7NfcsIvBPNIpY-zeI').build()
   
    awo_handler = CommandHandler('awo', awo)
    echo_handler = MessageHandler(filters.TEXT & (~filters.COMMAND),echo)
    start_handler = CommandHandler('start',start)
    pundachi_handler = CommandHandler('pundachi',pundachi)
    caps_handler = CommandHandler('caps',caps)

    inline_caps_handler = InlineQueryHandler(inline_caps)

    application.add_handler(awo_handler)
    application.add_handler(caps_handler)
    application.add_handler(echo_handler)
    application.add_handler(start_handler)
    application.add_handler(pundachi_handler)

    application.add_handler(inline_caps_handler)

    application.run_polling()
