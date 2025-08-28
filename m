Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09027CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 02:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0624027D;
	Thu, 28 Aug 2025 04:20:43 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id AE6C740263
 for <dev@dpdk.org>; Thu, 28 Aug 2025 04:20:41 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b4c61393080so451196a12.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756347641; x=1756952441; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j12JJuQv3Oy3Mdhq/7UQqozSctBXIqEq8IKOtcYm074=;
 b=D4D2pVjLyduOw0l6PhZKVsCTWmq7axjnXtNGJEISU0HzPhlJh5ocT+lJ24xv3qtLXj
 +4tZYgw5XTNZGD7pamu1yY2HWNW0ygQT27hh8ySKwQRwFU3M8Lf6rZGI5X3/mOtxx7Y1
 eUNUAJuk5EarDM2jxgLckDgXxk56RfvqBCjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756347641; x=1756952441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j12JJuQv3Oy3Mdhq/7UQqozSctBXIqEq8IKOtcYm074=;
 b=j8fJg/qOMK7dLnr2170fZcM0ZOvOukQFKd3BeQUqF+c/rxGHx07rhPVMbVvAVQfsfz
 /YFFAmfCMK5jHp+a4tGs4sfEvUPDK6k7w1Dr4GAkvJjH3avtGOs0KuSY+411QzeFxw6q
 Yp5+sxchhOPSwL6vcnktjo7Ju/gLoNFpFaq8/Z4aDTNQkyu4m7Web+k1myx8dBDf8lvc
 Bpy4Q1ydRAmmU0AJTnG7lJaC4Yf5nj6dolCakqgKva5D9xrq0AIiqO4Wp0nGbfWOjyyu
 g5Hxeoox1FLHYvTaoRl2cWriKpL9nFke+rkKt0VPxnOozvxH0r5o6t6H/MWTTYpNn36a
 E4qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeVeDJPNrCVe+ArWqd4JGlRdPGDJ0m7FvRxfWDwOm5O7w78GWxX4viqZgEhGSCIu8jWlA=@dpdk.org
X-Gm-Message-State: AOJu0YyAFdjcViHq6/GwBIV2Dis3lnV5q0Jg4bcL9aUkg2OgChD8Gxt5
 ZuiK83NaZgsm8z+W1K/lRm3DPWD49uSOLeS9ZW57Vo6VwqtdcSnk5yUizVgdRMgBcBMx7+7qTT0
 GsasuQ4pxTpzWf3a1Z685kURvSxe2T9tJMZip2OGcsA==
X-Gm-Gg: ASbGncsuSlyaleOg2gfF+u+/VZL6qqSiKsh0Kvj/reZeqNkVCoS5CjRcKpOhWTDurx8
 pjf2N/VBAk6NAQeYAmGKWqRl16OpB+s/OQgUPiPQNSwGSXw1glcXoHFsCDAX1QLxvGLzO7UXFS8
 6b9sDQE4+NDrLpK3A+D8aWcbcDHN5qCStnrqnb02bzpMeLDeDQJAPRqDGkprvI+rWI8GLuDUJ3N
 bf09vZemknzsEfD6UrqGK2G4cLRJr4U/+fPBVdXYCjO
X-Google-Smtp-Source: AGHT+IHRR0iFoV1zPRQ5P4hZVTu86m3of7y04SlnduANrdsQvdJvpbqbgxikA1MwEdY+KlI7ldZTWCD/JC7uekt4svw=
X-Received: by 2002:a17:903:ac5:b0:246:a132:8edb with SMTP id
 d9443c01a7336-246a13291b0mr186210155ad.32.1756347640797; Wed, 27 Aug 2025
 19:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
 <20250820140651.39604-1-dmarx@iol.unh.edu>
 <20250820140651.39604-3-dmarx@iol.unh.edu>
 <23c65370-c5d1-4ee7-b4d1-ff85ecf0a4f8@arm.com>
In-Reply-To: <23c65370-c5d1-4ee7-b4d1-ff85ecf0a4f8@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 27 Aug 2025 22:14:01 -0400
X-Gm-Features: Ac12FXwhItR9HmSJfzZ5s7GmAZ_rIKERbMKP2SUwmlGjGrSEPQU2EKtFprd0vro
Message-ID: <CAJvnSUBx+YL7VPVgbFddKB4+vDMUELn6=ht4EUaAizkbFB6WfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: rewrite two link topology requirements
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Dean Marx <dmarx@iol.unh.edu>, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000003b75a5063d638d36"
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

--0000000000003b75a5063d638d36
Content-Type: text/plain; charset="UTF-8"

Thanks Dean and Luca.

Applied to next-dts.

--0000000000003b75a5063d638d36
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Thanks Dean and Luca.<div><br></div><div>Applied to next-dts.</div></div>

--0000000000003b75a5063d638d36--
