Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C17F53D67
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 662014025E;
	Mon, 16 Mar 2026 16:14:39 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id C77AC400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:14:37 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso8962604a12.0
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674077; cv=none;
 d=google.com; s=arc-20240605;
 b=iz7yGbkNSMiLMTKKpOPkL+EgUWurjyFUWGnne/4TZmW6z9D7X4x3FZOEN1RwlSUbMg
 dadB2QAlQlHu+2at+eM77omIKE1i2RiyYI7Kf39WvsFJAkuSviaE9xuL4N/5ROMMMsCK
 nNu6ousMtAYuL9S0VhYp3HQAlJTHt8l5gfLvWKXs1euL048BvXJXY3gXsVil3LO/oQ4T
 50umfMH9mNFHbEFIz25j5V/tGQpx9Iit7zZGv4kA7Ymo/cEafQ5ZWBIIG8RmmPzN9MpB
 ge4z+kP0z2Ac8XnHB3n3pVDt2fphiWME7kToigm3JdOGZwzx9h+KKMkCIdVsI6KD1hWf
 eHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K+ysDuJFgeHGR1GihX51qAsm26G562mHteNsLNP1j7A=;
 fh=nRVxJ4TFqUj8gRs5NRKzYltwuGsN9gYU5dh78dz7O90=;
 b=XJi0HxHpXuTivPBjmCsjWDSKaBQuZa3ULTMZqcgRvapItbga4i8Y0vWr6IoSw5xkqN
 eVKb4l8ADu38rPYMo/14ghZsoUqv6wk+gtxkbuzUQmmeZACVqs5Qdp7dBk/e8804OA2S
 zbF2/LHB8maAxLQ/UV0JDgtCj2px2/Oogz+1J1eI7Wvli5pJfSBgyfT8OhFwgpS96bJo
 sRLlHEz10Ok+LiRCILFw+iylQm0yI/EP3ThfVFqOml3WD3su8F5gqVdpzw5ouOFvyO9W
 ZYsmxB+6aIMSgkEbLQuw7k/wzPLH2SOMav807y+K6JvkYWxXShKJTJ0CivVsWyult6+h
 jnhA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773674077; x=1774278877; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K+ysDuJFgeHGR1GihX51qAsm26G562mHteNsLNP1j7A=;
 b=DQNDiktCUVon4kXCvbYKvBcE1iCG4Asjq7W585oLUGwLIo0HA557Q+tVkaYTDmGn+m
 K67FpIk0NkSjQ1wirnGXrnN9KJxaAKqtHrSHjEqKQoQ/NbFthmFdh/Lt4W6AOKj88rJu
 973kCchjUILeYjxIrZMhQ3QppbrT1wYUYwOsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674077; x=1774278877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+ysDuJFgeHGR1GihX51qAsm26G562mHteNsLNP1j7A=;
 b=FimxxH78jdLRZoQ/xRIsb+MxTAxzmUSMUO1JZT0qg/yqy0Gq3l9S5Fweendl2PP4EU
 TSnj5g9g4CdGhtDqip3PgzzOQRua9O4fLGlwk7PdjHpWoT/RZePGpIPa5roasCm37rON
 fBX/rNcfdMxWI3VHEKcGBQ5awWjZl5fkWbRxlJwcE/TKx0f2LsYwZH4+NOAn8WQ0HB+U
 pT+f5eZYmN9T8ZtvJ7j+7npp/pUCjIfOIhoGd1ceHIGU1akxuCGRxBg+xTun51eJD1G0
 VRKf9cGRRNeLqkev4eUht9Hdm6sWMJ8RV9yZb2uiUiA7JdG/lwdZDHqcF9+1kpCjvOxn
 68sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI9hbWInoPHzCbR7XaSgiBCKeMYnx0Ul9Ro6HM8Q1z6DCrDC34RXeoo+oO8Yy06au0c2A=@dpdk.org
X-Gm-Message-State: AOJu0Yz28ELMa4nsGQVNAT07FJ0eXKyPN33TxMiFyAPUbhz34j/d1+lu
 GWGag2R+yeco6PPNAhLpQSkxImF5m8zRDcF8z/0juOurEtaofiRgGO4T2TXAhRzmE0+EhIiglik
 BPfvFoj1AWiJCSqRy2zG6HYqCMdtbdG4w/UYvLPaNmQ==
X-Gm-Gg: ATEYQzz9ihhOD8cT/tzuhATeuxMxZ+ZV+NtBG6grK/5p3K+M9TElFVRF6FhrwgNwZ4O
 j6ry5NExVvztwFTtq4ay6hY1vc+1/LHgDPEgUTFwgdeRggNp8gtnqmwXYFXFtixhG+GC7WujPAS
 ldgLDt+WwFYi71XOELtXRlr/pAyUX0/a8n9Aszkr7I/BQh8upb+ZcOgMzCYjanWtxRz2uYUAzIE
 YYOZdqjOEOVPSs4VTtrF5sHDKtB3I7335f4GJL/rK3lWsLSiXmhLCWdS7d2sABBnAAJcHVqBPYV
 k1ZHWKeI/NK57Yc5faK83nzguwgpFuyFw0iMNi25UA==
X-Received: by 2002:a17:907:7253:b0:b88:5d85:48f with SMTP id
 a640c23a62f3a-b97650f1ef5mr844018466b.14.1773674077352; Mon, 16 Mar 2026
 08:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260312203630.96473-1-dmarx@iol.unh.edu>
 <20260312203630.96473-2-dmarx@iol.unh.edu>
In-Reply-To: <20260312203630.96473-2-dmarx@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 16 Mar 2026 11:14:26 -0400
X-Gm-Features: AaiRm50SRebPnXJan1kwiPI3yycwzWLvOLZbMMzJ9vekLY54M_iXZcLvY8n8qkk
Message-ID: <CABJ3N2U41BsCWpbT_vrUft4ywNNNTbkb6qw5gK0zqngAH41ejg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add VXLAN protocols to flow test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000540566064d25adaa"
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

--000000000000540566064d25adaa
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000540566064d25adaa
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div>

--000000000000540566064d25adaa--
