Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9974DC71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 16:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA4E402DB;
	Wed, 11 Jun 2025 18:51:03 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 4B94D402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 18:51:02 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c5a88b34a6so5702785a.3
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749660661;
 x=1750265461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0W76TImiBnfFq2moFVCrgHfO7oxQJotTbC2P61OKNM=;
 b=m7VcKJsTdV7wUwOixDABveekxffTCZ7VlBLLP3mBUzGVZsX51/x03GmX0XegqjbOkl
 a5BssWBlVwx2y4ml9DViaQHV9+YXxFdtJuxxmi6pHxOC1mo7Ynm0fDleHYfKFzqq0/8k
 dngAqn5H+1LkW5YARsB5mOY4NHQMxf1mMVcFNcz5Qyarw+T8myd9ltpnHekHehLEWUoA
 xm/qVMPez4JYZd9cqQJwODnauK5NmCZrx66sDdNxAKPCu0O5QnPyBxv2/tcXu+Vo0eft
 A7JxEnnpWgS2F0nMhU+YHKGOqCfz2vbyAp7Jghxnw62mAOhGNFq7v79HqrgITVId7ybe
 f0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749660661; x=1750265461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0W76TImiBnfFq2moFVCrgHfO7oxQJotTbC2P61OKNM=;
 b=I1hFm7H6j/wDPZU/b57+fttDnbNgHudjMvQJZil+cUZ56lKw/3E3XYTEp9qfxXn9Cs
 7Mciwyh9/+iqyu/p81GEs3nKzgBG3OAOar3AQmYjnTlJlJv8MNchacsJxN+HlHreV3uv
 a7ArH0+0bNJI0Eu7wHrj7DlwfD+FCwybJw3Ci3W8q0WYQL5P/cMNRGqIjxeqRsk5AgVm
 vUJGzL44OxJ/+uqrtfcERNNhq3oQbnQ+EHPlyjAiK38d/e77q2LxpwLTI5h9m35kb6v6
 eTC+8VTO9sy37ts3N8oNjFystAN67J8sDBy9M0mNN7uJbpLl2mbzmE79yHPj1xal0AOm
 dQ6A==
X-Gm-Message-State: AOJu0YxOUDu0JU4CaV6/dTTDrwTnJqnjFEC8JhSA0c/L3MjqIPcj/odS
 BRKRjpaGtCidOUYxsHmaQfKcgolDwrOmQ6WyhEOOa3b5Y6KuuJSu+wvfu4NVvrxh+8o=
X-Gm-Gg: ASbGncvj1su93aLHEzWTmF+ypWyJrRZR6u1mfml/hYJeU/9u7b2UCcBfENnqbg6OdTc
 +0BBTKsX1RUfjFrFAirOamhaPLpaIGGWbMBrkeY+1i+sLflvq/ifW0uZSRvh+EdjuM04m++x/YC
 jcLFlQAPUuWGRwQK2F6CgpQEM6RhAHTPb1VuCLcolVUSrFKxgFVE2pKiS9DlGdD0Hr8hYzdcL6v
 mt/zE25Vw8QWRoC4rGL+wZyC3f1Qr2PShN9+Diu2sBkOeIgke3E4zbUtwqhYHmz61t8cn//0gnK
 t+/qXAvLC37qYLtbDp9HnkxUvje3E1zQJljZp+caJ3bp72t1wMaMs7NVa+wRDu9s690orWA15+S
 De+Al0/mfh2FfQaX1xUI2ZLHWM4sq2mlt2m/Pe6I=
X-Google-Smtp-Source: AGHT+IHdGR2uL5tmBMMw4ZEcDyzcYhIB3HLk0fXna8sp8ONqA+EvLR+UoBjm0L1AxcocSE7xujD4Eg==
X-Received: by 2002:a05:620a:4083:b0:7c9:269f:b654 with SMTP id
 af79cd13be357-7d3b2a6c44dmr36898985a.27.1749660661493; 
 Wed, 11 Jun 2025 09:51:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac84b5sm84232676d6.29.2025.06.11.09.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 09:51:01 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:50:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 02/10] bus/dpaa: add FMan node
Message-ID: <20250611095058.19efbede@hermes.local>
In-Reply-To: <20250611071039.2939950-3-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-3-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:31 +0530
vanshika.shukla@nxp.com wrote:

> From: Jun Yang <jun.yang@nxp.com>
>=20
> Add FMan node(s) and associate FMan to it's interface(port).
> This method describes FMan attributes and avoid accessing FMan from
> port directly.
> Logically, something like IEEE 1588 is FMan global resource,
> which is in range of 0xF_E000=E2=80=930xF_EFFF.
> Port specific resource is in range of 0x8_0000=E2=80=930xB_FFFF.
>=20
> Signed-off-by: Jun Yang <jun.yang@nxp.com>

This looks like a typo

### [PATCH] bus/dpaa: add FMan node

WARNING:TYPO_SPELLING: 'contextA' may be misspelled - perhaps 'context'?
#147: FILE: drivers/bus/dpaa/base/fman/fman.c:125:
+		 * Set A2V, OVOM, EBD bits in contextA to allow external
 		                              ^^^^^^^^
