Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1ACEDD97
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC427402D3;
	Tue, 18 Nov 2025 15:34:49 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id D06F740150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 15:34:47 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64149f78c0dso8527937a12.3
 for <dev@dpdk.org>; Tue, 18 Nov 2025 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763476487; x=1764081287; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HEoQDyW9Cdfsb2YLz/Y6g2ZxkqtfJYES1gk3S82e3xo=;
 b=Llju4Hv+9nmXw5N0zdA8u8Dq86daYyohFzYNRYktpyTIMNpAe7hN3juTYCjGN3ye4f
 TPjA8Ff4Jcb9zjU9J5palmPoPtGdbQEiPg56mf5PQVAOF99w4Yk8DvRgazrmmID5Bs4l
 6g775qLQomCq92rRXfwOLVI1HF5OV831P8AkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476487; x=1764081287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEoQDyW9Cdfsb2YLz/Y6g2ZxkqtfJYES1gk3S82e3xo=;
 b=k94jtKx3MhA1oQUkRgfzDsdMmtIbhqklOI85JOqwZuo+xtekk/w5lOKNZAK5uHzwFT
 kaBQkxaj5EqQFy/mlVXFReC7cMnmShWtXHkD6zUoKiodBUn3YDvC1GzPbXBRgUJJKUs5
 K7Tn5I3NLz0nL//YgYIZdl4z1E447I9Ehu41iopUTpXVIgcvL4PjUfdWGnPCAGConi5W
 cugV+T+hhN6c2G6tR+c8Se9bw55Aqa1hnHXzfFZOfAGX+FC4uU0erRFEFr6K1ZBjqkzd
 KAreolaj50WR5ua5c/wQhlGYS08wS1pyYzKryH/WpfJ+b0WgllLorVhlZQEOq6Y92Qxb
 Zsgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPRsrkRQ01hmRDLY5hQBak7Mi5VPBY5737kz0AgEY37DjNQKlcC1bb3fXZHhDTiiDAv1M=@dpdk.org
X-Gm-Message-State: AOJu0Yz8VNwIcAl2PcJr+163cd4Kiv5AfSfMxb+8igsh9Q1X7XHiaSTO
 p4koVQNXtZa2CGt2CmHK/+j+h/7xsZdlj/VRVwOIaeMH9g7xMjdPYQRotrtFU6qAemMwyt+0gvC
 x33aSneY/3izrVkASHhrhYziVqL20q7ZoSWFw/zDeag==
X-Gm-Gg: ASbGncuyv67PVS/q1RZjZ7n0mCl0BKmy0ShgiOX9qNJslDkEcOA4qIDNYoT/x1MjaY4
 UjjOS1HGCP49ZRFPmcW6zXyLNTU7z6z9mo7e3oSkXNUylZXIMO8rCd7Z2VvAtXE+vk6qt3WYsqP
 nLqaNJopRVUD929Gxtwk0IWEb1aw8QwYlcQmyhaJIAKwAP4F1Z34qh7c3WPPGh9g5HYmeDjykOa
 Su0tvr6Putm9MdWYX3XvHtBpyX9GDfmmPgVIefi0llklsIRwYRMNhPw2HYImal0xEI4pKAf6JAk
 eHLbxG38aSk=
X-Google-Smtp-Source: AGHT+IGrpQErwL/hPST7TvqvMkF3j6vZe7I8t2IQyGm88Y+fd6vjeUo3nHpENH9PgBh+KBTn/owiApIOhb+OnED+EBw=
X-Received: by 2002:a05:6402:40c4:b0:640:948e:7da4 with SMTP id
 4fb4d7f45d1cf-64350ebca89mr13989061a12.29.1763476487198; Tue, 18 Nov 2025
 06:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20251113232954.273454-1-probb@iol.unh.edu>
 <20251113232954.273454-3-probb@iol.unh.edu>
In-Reply-To: <20251113232954.273454-3-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 18 Nov 2025 09:34:35 -0500
X-Gm-Features: AWmQ_blGC4hJCYBps7zXlJrPJoXmf-2XokR1O7DU_VsQ2zoNpBkpAml1T4aogRs
Message-ID: <CABJ3N2UFwzUi+iuX3+HM9du1CO7riNNVj0M5FMy5YUR-gmbNQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dts: shorten a too long line
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, thomas@monjalon.net, 
 david.marchand@redhat.com
Content-Type: multipart/alternative; boundary="00000000000096ec9c0643df5d45"
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

--00000000000096ec9c0643df5d45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>


On Thu, Nov 13, 2025 at 6:31=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Bring a line which is too long under 100 characters, which
> is the limit.
>
> Fixes: f6fb8c6238db ("dts: add link check on testpmd port start")
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/api/testpmd/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index b6f5a8f0da..e98f882b14 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -96,7 +96,7 @@ def _requires_started_ports(func: TestPmdMethod) ->
> TestPmdMethod:
>          func: The :class:`TestPmd` method to decorate.
>
>      Raises:
> -        InteractiveCommandExecutionError: If the ports has been started
> but a port link will not come up.
> +        InteractiveCommandExecutionError: If ports have been started but
> the link won't come up.
>      """
>
>      @functools.wraps(func)
> --
> 2.49.0
>
>

--00000000000096ec9c0643df5d45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@i=
ol.unh.edu">abailey@iol.unh.edu</a>&gt;<div><br></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, Nov 13, 2025 at 6:31=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailt=
o:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Bring a line which is too long under =
100 characters, which<br>
is the limit.<br>
<br>
Fixes: f6fb8c6238db (&quot;dts: add link check on testpmd port start&quot;)=
<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index b6f5a8f0da..e98f882b14 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -96,7 +96,7 @@ def _requires_started_ports(func: TestPmdMethod) -&gt; Te=
stPmdMethod:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0func: The :class:`TestPmd` method to deco=
rate.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If the ports=
 has been started but a port link will not come up.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If ports hav=
e been started but the link won&#39;t come up.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--00000000000096ec9c0643df5d45--
