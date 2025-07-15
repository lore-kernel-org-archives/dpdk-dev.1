Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA4C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 21:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BDFD402D4;
	Tue, 15 Jul 2025 23:58:24 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 24B7C4021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 23:58:23 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-af51596da56so4972971a12.0
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752616702; x=1753221502; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2mH0sSLVxQONGlOPWc17bA3OIRR4hU/hHjgRGMmNl2w=;
 b=OuBYa8UOYOR51ew7GVajd8oZokhuEo6hgd9LPEWSHOUsWQF3cFcFrkVdhRakiGf9xV
 YlpP+pe1fM8GsCcIMUUvptGljKziZqIu8d2XvWQY+34twrlXeCbe6puRu6N2RBc4MCIT
 375w0idZGmv2A+BayzOvAwPZtSWWjAHQXMWLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752616702; x=1753221502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mH0sSLVxQONGlOPWc17bA3OIRR4hU/hHjgRGMmNl2w=;
 b=d2tqDPkNdZudu4gdVpWNhzOvdHyTqfaruhMDAT7s4xc6nUwEyr/Gp6tcfS+BT/009p
 ujFQX16SQSuAF54QBxi5GAbpdXn+UK+qBh7n6gfBPn0R2qtU440l1MN8Wcbw+ntLN4kj
 SMpqrybzu9ONwD4lruPq6leiQKU1BFVWkv7KH980TqniTkVroi+IGMm+pwx4vVjtotOH
 ZPavIXoODKuZ5Wx4Cn5GWMdVkp7m4EQHzqJx8DhjOBOxLAQ27SUh1XTx3XCiB4BRtSgy
 OOJ7p6LerEbC8eqPRQpSmWj3yZTokEXuvXBheEc0lw16LQG/sLO+4Vf7HE394XAH+h/V
 8GHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Wv0v9D9bloHg1pcjLDM9msMEpi3SgIspxn4TlDJRcR8QQ4mnudouK22O5fc4kPe3svc=@dpdk.org
X-Gm-Message-State: AOJu0YwtFdVQ9rIBbMJPDVU7+v0rlmbIXE7C9/oSQEJEycyFS0cGjqRL
 1RgD8gmUpfj4HeNS4IH8mEXQEG6YP6RuhWj8UYhfMLtQvWId/JamjwufvNTHwdaI4a9giHZbBT1
 nAxYnnwEE0W0M8OnhUsx1dbNZRqmJDvKmcMNpAzE7kQ==
X-Gm-Gg: ASbGncvUNZWTCUCDTU0oenNDPq0CZ0751P0CgcJWOEtkxVVOZjSFJ1yVibT7t1Cibt2
 +pcSBQLJc9n9XOq8mapSfcxVBq0SlhRxbS79r2VxzO8CZLRHunXLhdjae1O0C8rjc0YUpskC3gP
 rxADeqBE7Jufu+NqWWPbh/bdvC7dMZTR2p9FX83PVebPYE0qoY8CwJALmmty+pC/jlSYrFlx/9e
 5nu7ZjgDQ==
X-Google-Smtp-Source: AGHT+IF1mfqTqxYdcmzT4wtlOjMK0kM5R0YALREpN4kG6gDh5tiazCTpGAYW13HOwZbfVWriToW4AHIZ9RKNHvoE6t0=
X-Received: by 2002:a17:90b:3c84:b0:313:dcf4:37bc with SMTP id
 98e67ed59e1d1-31c9f4e0ff5mr298854a91.34.1752616702246; Tue, 15 Jul 2025
 14:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250711172534.540416-1-dmarx@iol.unh.edu>
 <20250714171346.564267-1-dmarx@iol.unh.edu>
In-Reply-To: <20250714171346.564267-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 15 Jul 2025 17:52:31 -0400
X-Gm-Features: Ac12FXwI0UhWKoGWk2LawVN304hFbrju2T1Of7FeT8POdXV9tsEgNZckYFxyafM
Message-ID: <CAJvnSUCjRspat=S+A6jSH+tvhPBZ7Re8nUM1WE62sVN9Jq7z3g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dts: rewrite README
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f71a080639fedf04"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000f71a080639fedf04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 1:13=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

>
> +
> +# Simple Linux Setup
> +
> +1. On your TG and SUT nodes, add a dedicated user. In this example I wil=
l
> add a dedicated user for DTS.
>

This is getting away from what I was suggesting. The original version was:

On your TG and SUT nodes, add a dedicated user. In this example I will name
the user "dts."

And it's English semantics but what I was getting at is if you are going to
call a user "dedicated" you have to say what for. I don't like that you
have now removed the "In this example I will name the user "dts." line
because that's really important info. So in my opinion the final version
should be like:

On your TG and SUT nodes, add a dedicated user for DTS. In this example I
will name the user "dts."

>
>
>

--000000000000f71a080639fedf04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 14,=
 2025 at 1:13=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+# Simple Linux Setup<br>
+<br>
+1. On your TG and SUT nodes, add a dedicated user. In this example I will =
add a dedicated user for DTS.<br></blockquote><div><br></div><div>This is g=
etting away from what I was suggesting. The original version was:<br><br>On=
 your TG and SUT nodes, add a dedicated user. In this example I will name t=
he user &quot;dts.&quot;<br><br>And it&#39;s English semantics but what I w=
as getting at is if you are going to call a user &quot;dedicated&quot; you =
have to say what for. I don&#39;t like that you have now removed the &quot;=
In this example I will name the user &quot;dts.&quot; line because that&#39=
;s really important info. So in my opinion the final version should be like=
:=C2=A0</div><div><br></div><div>On your TG and SUT nodes, add a dedicated =
user for DTS. In this example I will name the user &quot;dts.&quot;</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
</blockquote></div></div>

--000000000000f71a080639fedf04--
