Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F539C54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 15:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C2F44026D;
	Wed, 29 Jul 2026 17:15:11 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id E9E3540269
 for <dev@dpdk.org>; Wed, 29 Jul 2026 17:15:09 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d01663d816so10156895ad.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785338108;
 x=1785942908; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hgMGMX7FR39CvtdAnVUQlyvMrRRZ7i5UiRwjb+cyCEA=;
 b=QEpaJF2vHEFTe+zriqO6LI2ANZSlrWQWal8FoJf09OpeUEacvB1Eg65FMsthjRDAlS
 QUH5W/hzR75UvD3ZJ80oPcMNRLHpt64GlrzN843+lQQENBNqn1knbtIZZxAUEtfJelec
 YCMjLmq24z0EmEawHv7EDtMpYY36w6dydx10VAruRgC3EsqCvBVHBwMqt3LKhY2RhWFb
 fOjAQ+eymksp3MVO1uBs759Tuby4FM7Tt+QQ7tQn+eFiW9i9vKvax5hzzooABHXf8iJc
 isbKbe1ct2fGo3hso5WxDY7yAaGcTiFQBLX2zNZ52LnDvJTk8ipHJSWWvevS8xEAtfcC
 +jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338108; x=1785942908;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hgMGMX7FR39CvtdAnVUQlyvMrRRZ7i5UiRwjb+cyCEA=;
 b=aH+TBm61pcDfywmRB3Vaz+5OFGUfg1dkoWTzgtrV7yMOn/qs7v6xXgS+42G/os2n0g
 NAtWdKmBTEYSam5FpWgOH26cN2yk7o1Ga8WWmtWdlVVTv0iY1tIwwvbABkXCCeLVYC3Y
 I4AvtlWtLydcXYf6pbtu+E+aqBMpdcuF1/Bw3pM+QssHISDLVD7W8uxxlU+yjpU/mhJ8
 yzb2IDCLOcN2f/JwrDWK3M+syrBh1qo4YXnAkN3HCgEF63TjSQkKrZRITw0ET9uG99nJ
 NfQ6Yw7AIkP7JYFdV9GkhJcKFThmepirwbEUz69eIeLUiK1AyyJLJcLQyHlHNC00Bixb
 pKYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfTQUncQkSDK9+4vqutiI1jTrsSG7v/OTRwiE7tJcfjfOzI4Sp+m2Mnj9kZydADRztpkk=@dpdk.org
X-Gm-Message-State: AOJu0YxBSQvhdTSfeKB28t1zm6+CLvTkv8DGibW1xqy3h8VIXeEUY31O
 HoSNgJ53TcB92qFarWfq9LrpZMb5CIu2XEcninUS+uyEIXkGhjYE/ydhFhu1PgOJPauFF6g0OOV
 MzRq/
X-Gm-Gg: AR+sD13U21iqkrJXqsu0FJwtF/KsBvwDAwV6QmZG8i2O7qbdIyHSHmp3kJ+tExFBraL
 zR411hktlDs/xdfm7Fen7hv46bj1ichsz9RQ49oUoHRzrzSpLu3EtuUpbqEhxMunBPf21N9U/dK
 XP6q5N0cRPr6r67p46bg5141OFqc1DAUCzwn+zq96yjSx24VSYIVCU9lv7Xeuib3TPJepEdPYJI
 vasV1Fkal0EQznLy2kgtdDHkuWbuVLjX7IY3qQRJofkAZ1BdzKF+pUAa0eP7IbZB0R+9+fNzvWC
 u3XaeZOh8nGw5Ce9NSsY03msGvVNgUmnSp+D2qTFaAS6z2lMGEXqSb6m0l4tQBdWApf/9hz3IAo
 h/ljLoxWOILQp50fdHUteSKvkMRZhF5XKiJJgd7ZuQw8EajH78EA8VHS/9PdtD2LYL0iO4hrzTs
 58KKUE85zoBAPAyjbHTzqlBDO2ztZ0Xl9vkPAHDM1M4v42FwOxgp5jjDj3QrWPFt3ZXS9aATMnb
 vxmFp+WNRKBBGdEK27BkM/1sKsLlQ==
X-Received: by 2002:a17:90b:2d4e:b0:38f:474f:e6b with SMTP id
 98e67ed59e1d1-38f6a5ae1f2mr8121456a91.41.1785338108169; 
 Wed, 29 Jul 2026 08:15:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7271e9d3sm9961056c88.10.2026.07.29.08.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:15:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 08:15:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <khadem.systems@gmail.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Subject: Re: [PATCH] mailmap: update Khadem Ullah email address
Message-ID: <20260729081504.6f359bbe@phoenix.local>
In-Reply-To: <20260727062821.42394-1-khadem.systems@gmail.com>
References: <20260727062821.42394-1-khadem.systems@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 27 Jul 2026 11:28:20 +0500
Khadem Ullah <khadem.systems@gmail.com> wrote:

> -Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> +Khadem Ullah <khadem.systems@gmail.com> <14pwcse1224@uetpeshawar.edu.pk>
> +Khadem Ullah <khadem.systems@gmail.com> khadem <14pwcse1224@uetpeshawar.edu.pk>

That doesn't look the right format, need to drop the "khadem" there.
