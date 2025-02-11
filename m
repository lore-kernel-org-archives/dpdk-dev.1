Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A7C021A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9F3402DA;
	Tue, 11 Feb 2025 17:16:06 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D5900402C9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:16:04 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso91370685ad.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739290564;
 x=1739895364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzrM6dmae9iMIsCxZ7yubTou4wouL/BtT+YuzY+X0l8=;
 b=qXaxbVweS7cRfUdDc8lV86H/I/4gsvpeGULXKOArMNVHy6PUwbwVoyMi9OVKat+PW3
 gywAhALLo3Thj12o3yK7ucHPeTNvhfd8lIwhSSkEr8xR4DaOPo3wvTswSB3V+2cGJtsA
 AcyffiqlF+cBPBHyWePEEi89nCO8nZi2uCvgztdToCyz16NpbZ9b+LxLNuE2d8d0lnmD
 yB862GY8LrGsOYsk8go9W1ZtwKkxd+ydtAls6PwApumiw3JtiRp12QTTLXl+SC0vSsbF
 gANJDw8vfL1LnGIUgSXdQDmqWeXD0OHn1lKBI+a4xjfpxxzkGLKxMsSInz8JiLIF/SC/
 089A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739290564; x=1739895364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzrM6dmae9iMIsCxZ7yubTou4wouL/BtT+YuzY+X0l8=;
 b=OqZJKHV0vbaeskV1KdzMSdMzO1OLbjl7KpvmIeBk5K/oMiVqDfjccXefRtVyxs0rJl
 rw15LEWMF6GwGZ5aziWkP98arxxhsfk1KrsvJE92RCIK5bn/fGqi4iFv5eWGmPLQjyvq
 uK+u55ohp5rkUECdnezt5pUzvBHaKn6ME6HVfk1D87j4lWBTyj0AmYTN5eYD6FLWrmWG
 djNmyT59vyWkJq3UHOfCP+Xm8I26+bx4OTLk2BBm515QF2rWKCkykWmUUfIoNYL3itzX
 ZJcXuWBVpwtRd4Rp1VbF/qktrpy32x9surGP0MEbZHWp4HazJnxQbWX3HyQNaCJXCKk6
 oOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyp3aZll+Z5dOXV8X03lyhAS0nZKHE1leWlutjhhKP7li+17EshknHssueykJl8kAHML4=@dpdk.org
X-Gm-Message-State: AOJu0YzlPsCzcu78sYYSDRe6sgqZCEqgPxIzPVxDFHFM89+FR3ViX5ce
 KyIQVHSQ0GMgfAzFpV7IbKt7nXbBdExtaMl4w0R0qXIqFiuHyu1IXcbw4laluo0=
X-Gm-Gg: ASbGncvtQtGj5TyuETTJDTegtQrCssoqZ1bbgWZPsByheC3MHHY/gS8f4vwPGm4qDWb
 bwpUFZz8ake26s9vWk7BMMyXNBrcbvIm/M0gBixgc1xDm3Ka8ytdUuZZz9PRzE/udJPw+DCPVhp
 uSpHL7AMrzWw9YcqlecBSO8sa5MG+u0A98s4fbSkdoYvlNwr99SsZeVFL8xRK8m3tKkkhujNu8v
 aOgvhr8lad2mtTUKnQddL0NDSntPFbpTKqu6NlIc4PPpjXuDRKwQzL63p5N1JQrsEYDZY66Jww6
 YwzSkYZJ8YVFRe494fLhQxdT2gQI5cwInnE+SCs4mcdb6cemOr2v1xAQY3UQXhrmqywb
X-Google-Smtp-Source: AGHT+IHhfsH3l2vBYpG9S2VRG12xcx5V+pr0qDjsjEk3hX9Hww/QOM8hNhMWTD3YhUhmVrYb5l10hg==
X-Received: by 2002:a17:902:e54c:b0:216:59f1:c7d9 with SMTP id
 d9443c01a7336-21fb6f2394dmr75858305ad.19.1739290563962; 
 Tue, 11 Feb 2025 08:16:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f60238538sm72321945ad.120.2025.02.11.08.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:16:03 -0800 (PST)
Date: Tue, 11 Feb 2025 08:16:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "11" <caowenbo@mucse.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
Subject: Re: [PATCH v9 00/28] [v9]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250211081600.34cff0a0@hermes.local>
In-Reply-To: <D097802739E0FA43+000801db7c98$387d2380$a9776a80$@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <20250211065649.1885ab26@hermes.local>
 <D097802739E0FA43+000801db7c98$387d2380$a9776a80$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 11 Feb 2025 23:18:34 +0800
"11" <caowenbo@mucse.com> wrote:

> Hi Stephen=EF=BC=8C
>=20
> For rsic-v,windows freebsd plaform, I need to limit compile meson file wh=
at we not support ?
>=20
> Regards Wenbo

You can stick to linux for first version.
I assume issue with risc-v is byte order.

All this can be blocked in meson.build and should be notede in release note=
s.
