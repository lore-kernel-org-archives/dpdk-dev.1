Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F9C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 16:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E8C140E03;
	Thu, 15 May 2025 18:58:59 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3F45E40A79
 for <dev@dpdk.org>; Thu, 15 May 2025 18:58:58 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-70b4e497d96so11289037b3.2
 for <dev@dpdk.org>; Thu, 15 May 2025 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747328337; x=1747933137; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwsaqul/aXKv0karPpzMif9bG54+V1PQYR9e731/AKs=;
 b=HWfu8gImYmpm1LIw1BDSkbEPZ6LKFNp85ZCXQK6zc85jY15f5GAjdhReiPJFfDwsKz
 XtEFRJq/7xQ7A/6j0rx8np1oTyjsbvfi8+Hb4VheQbqe3DtAiKkVxyOVYgqFsxxnb0Ad
 HF6daTd+Pe7dCg68pkzM1zrf3qIYtmxJVwgpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747328337; x=1747933137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vwsaqul/aXKv0karPpzMif9bG54+V1PQYR9e731/AKs=;
 b=SUddBUAFRoIb9tfB7sa3QqP6rcP9g8sRizNfT0aK1k8K5I8TgCEUYoUv4VmW9aN6lF
 6CYZutCx1lr78NBN0JPgBTB3plKyOEKHWyXxjxv/8Kd8dm31vy3pgSBSuDkuf/1/A4Ol
 yG3PSq4QVbNezyyXPZ80mcuUt853rYeG+M38EooQ4fDN29XGdz3CYXfbb9DXuho6BREf
 5SUx5uzamdGljTQYFp4vAza6vaYZ1zk8INd+HbcktN2arHiuHEYGTwxsR81n0Ybxzyhj
 mIBlwfDAVNNEQF55kahMtmqqvxdt4k+q0LdctdLDaI7+tExpxaWhYMKAog+aaWhTDU6n
 Rfbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIrN9kSCmBYzHN5KVZOXrd7raRcmI4vvi+wjmE/kSEcw7I4//Ga+d+gUGxsu3EUK/B3I4=@dpdk.org
X-Gm-Message-State: AOJu0Yy4LfbrjrEoojOVKn6H0vFpGDXRd6BaJM24g3NVCp8UYRPLArCF
 tChs8ucwLhe4wD2A924cPERIVcvt75+hr2f0tnTTmtxUaIPf7y1HLoTMABw+mXntlNZV/CERzLu
 nNh0gGkroxIdq5W7lSeEtz3mcUovq/pjZzvN5fbNhPw==
X-Gm-Gg: ASbGncvbITQPE8ltH0c23+Nu5iviyR9EvAH2PYsMeQjkUFfbaocMVJRmSXQH5gEdtKo
 hjFpgghCICHAaz0hBixTyypYMmyZspRYc0cPda+bpG1CEc41Pki9t11ny2da+j82F3GZ6bW0q28
 KBEGwC44ZScdwQJ16owyReIGRg0fHaVzCyydkCaWLuNxXD5Mj3k46xB2vurZo9df0XPH4=
X-Google-Smtp-Source: AGHT+IEMSUX1aFqvg4bbp530ZlxhJTwCikvjcrXuNx3Az7R4z96OP/PStMBLxQ5PNOq6j4a1FXvdRxj4kF5VziqekzA=
X-Received: by 2002:a05:690c:88c:b0:706:e7c5:409 with SMTP id
 00721157ae682-70ca79e468bmr7571387b3.15.1747328337630; Thu, 15 May 2025
 09:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABD7UXNy9yymZ0+4SfHJ9tcA9ibg1rfph8Ee1tkgPxsbJwtaGw@mail.gmail.com>
 <5050697.TLnPLrj5Ze@thomas>
 <CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJw8w@mail.gmail.com>
In-Reply-To: <CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJw8w@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 15 May 2025 12:58:46 -0400
X-Gm-Features: AX0GCFvxOaX75AIZLrhrKW-Z9ThrYkOF2B8UZFfGeMg3iVs_ZDtF2rYDLLU31cQ
Message-ID: <CABD7UXNfQ0M7Qed+-rivctXxQVFmkt2XhKBA1LH=P5wdBP7kPA@mail.gmail.com>
Subject: Re: Flow API Test Suite Inquiry
To: Thomas Monjalon <thomas@monjalon.net>
Cc: orika@nvidia.com, dev <dev@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>, ajit.khaparde@broadcom.com
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

I've submitted an RFC for an initial Flow test suite here:

https://patches.dpdk.org/project/dpdk/patch/20250515163809.184720-2-dmarx@iol.unh.edu/

It covers most of the functionality discussed in this thread, besides
jump, RSS, and represented port actions which will be added in the
near future (once VF and RSS methods are added to DTS.) Any reviews or
general comments are welcome.
