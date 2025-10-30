Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38ACCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 14:53:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4500D4026F;
	Thu, 30 Oct 2025 15:53:47 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id EC97240150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 15:53:45 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-63c21467e5bso2358293a12.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761836025; x=1762440825; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJcZLzSaSqp6Jrc6EM/101YBLkEjV85ydp7ap/FuooU=;
 b=P1EKyDuasCw9T7tatmTrAjD1k365S5A9tq3o+0QjFxposIbM8i6l8j5QNILx+bOZyl
 7jZ6MsZ36FWxUOWcNPGZ0NkdBNGZlxEgVlt5uuIJnSK1uu4xEvjxzxH84JR+3Tox8YmI
 KtIMxSxjORQpWovfbyfM0RWXsIzdIBAk7BFRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761836025; x=1762440825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJcZLzSaSqp6Jrc6EM/101YBLkEjV85ydp7ap/FuooU=;
 b=e6jqT1hxKV4Qagn6NBCuiWuSLcoqE4FR2qoe5EdxlT9tnsfS5VeLV7GUYlaAJKpeAX
 ND2V6M/DzbZnUwrKNwLu36pSn3uJ20Vz3giqXF6+PQ27wwYRVAt5AtWNIlYk1SYoLmlp
 fGDm1C012XdzEKz5mnV55dvRK8SJ40Oj+IBJ+JFLIRlJgWXZJ0XgpV33MhTXbrnZp1Kw
 /hDHSoOKPa9NyoX79IWozOPbKKml7sU7+WPSW4x42vuxRL6/ubfYO30842sywrPq0YPH
 laGX3ISY2MOsV710+79TnXaA1qwyBeuM5W7fEEwU8prggxhYFxDtOTv0TIyFNZWYsuKA
 5AIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6QCC/a7WpTkv/zQzR1jG/PSfFJoJ5lziYbxAUo81GA2leRfH0qou2ilCEqq+/YQAKXpQ=@dpdk.org
X-Gm-Message-State: AOJu0Ywc3DLdO4TFi8cxDucVby5hDSLz9k+4IdqQs6bseTFI91YwCqJv
 SgtzgcYDCehciwRx2P6EtkwuIljJ7QCSc3Vx8KqmqHQBObe/Z7KKi37OLpIf5WjcY1Mvwv7xWql
 gjiBeEqZ0sYJRWdQYx3g3PgaFF7tOr0ZqVtpuNt2DLA==
X-Gm-Gg: ASbGncuyKo2XZbZG/eRRpNUJ9TsNbOpMc4qtLj53An08Zmjy1ArXVLpJg2IrKt5TgDw
 VOzucrBlB7jpfUOhtM5RXbkdpikb3xTPiJYRhWyjnWqxhZ5h6Qcr9YwDviwXqeFNmF19RUl2I/h
 tP8pm2PyknpGB4wcBBKGAItm5wdwCStZ+BbclJDTvZUlUn5kl+Pn1053t6WkyQXleKj4vNCxmQe
 ZzYSbDIPJdNFbmGxqeF9V977bgyTPAC01/6T87LSU+OThwnke8G2KbVB4YufHVwJrX7FQQyWWfc
 qmH6uvb9cqD1M8Ccf5ETxfGj/QfN
X-Google-Smtp-Source: AGHT+IF0SBEb+U4IImfOs3HxHHz8eujdwsjTQcRkvl1zpfbIT2ItZTsu33DJNChDnxl4gVsgCS1NwwcwA43ujXQa5uY=
X-Received: by 2002:a05:6402:440f:b0:63b:e822:ac3a with SMTP id
 4fb4d7f45d1cf-6406167d3e4mr2895959a12.0.1761836025546; Thu, 30 Oct 2025
 07:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251023013049.1368129-4-probb@iol.unh.edu>
In-Reply-To: <20251023013049.1368129-4-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 30 Oct 2025 10:53:34 -0400
X-Gm-Features: AWmQ_bmJ2q3eNvRSJ6_3XMTa8_7xGrV1GF9_n3QUmMm-L6FCyLOtYVtw2JCEoOI
Message-ID: <CABJ3N2XALBsU7pw1LQUJNixgHzW2CSYo76PZGUMXMMJFyq1pBg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dts: add performance test functions to test suite
 API
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.ed, 
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>, 
 Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000007499690642616a7d"
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

--0000000000007499690642616a7d
Content-Type: text/plain; charset="UTF-8"

   rx_mpps = stats.rx_pps / 1000000
   Nit: not so important, but you can use _ as a comma separator to make
bigger numbers more readable. ie. 1_000_000.

   Args:
> +            testpmd: The testpmd shell to use for forwarding packets
> +            frame_size: The size of the frame to transmit

Missing full stops.

Steps:
+            * Create a packet according to the frame size specified in the
test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above
the expect
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than
expected_mpps*(1-delta_tolerance)
Missing full stop on step 2 and verify.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--0000000000007499690642616a7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div>=C2=
=A0<span style=3D"color:rgb(80,0,80)">=C2=A0 rx_mpps =3D stats.rx_pps / 100=
0000<br></span>=C2=A0 =C2=A0Nit: not so important, but you can use _ as a c=
omma separator to make bigger numbers more readable. ie. 1_000_000.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span style=
=3D"color:rgb(80,0,80)">=C2=A0=C2=A0 Args:</span><br style=3D"color:rgb(80,=
0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 testpmd: The testpmd shell to use for forwarding packets</span><=
br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The size of the frame to tra=
nsmit</span></blockquote><div>Missing full stops.=C2=A0</div><div><br><span=
 style=3D"color:rgb(80,0,80)">Steps:</span><br style=3D"color:rgb(80,0,80)"=
><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 * Create a packet according to the frame size specified in the test con=
fig.</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,8=
0)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Transmit from the traffic =
generator&#39;s ports 0 and 1 at above the expect</span><br style=3D"color:=
rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 * Forward on TestPMD&#39;s interfaces 0 and 1 with 1 core=
.</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)"=
>+</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)=
">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:</span><br style=3D"color:rgb(80,0,80=
)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 * The resulting MPPS forwarded is greater than expected_mpps*(1-delt=
a_toleran</span><span style=3D"color:rgb(80,0,80)">ce)<br></span>Missing fu=
ll stop on step 2 and verify.</div><div><br></div><div>Reviewed-by: Andrew =
Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&g=
t;<br><br></div></div></div>

--0000000000007499690642616a7d--
