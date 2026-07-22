Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F18C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D276E402E4;
	Wed, 22 Jul 2026 20:20:51 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 29D8540270
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:20:50 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cacf197759so154391005ad.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784744449;
 x=1785349249; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C9AlQGRYPaeHq3XU+NXkm2mQawuw3A9F/h7QgfkDJ9w=;
 b=VZ6OUgCWfNuo32nzl9ERJk4f7+xfmrHJjtcF1j5W5o5nRHBnqzZvNZHtcowrxWuqNh
 oT0S26MNYVTtgc9NxmxywQqdYWbXHQE1nCwzb7PPROocRvwX2pH1S2mGxkOdR0S4G53I
 YpKzQqVsqThifa4AfoIad87pKhmpqB2eYj4Bj2cUVn725YxKBJ6npty7Op+nPgOEoOEf
 aMGV1LACwQYH+5ud3dqqsyJ3iivgidv/JS+UD6NdsucH7T9OIeISqONsUzFn8bWugVQR
 UvrJEbCRO5nTPz8zQJVSacPPDto5WodRqXYG0709IwWRosw3uqqB8IW4kvMg51+C4sXD
 oCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784744449; x=1785349249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C9AlQGRYPaeHq3XU+NXkm2mQawuw3A9F/h7QgfkDJ9w=;
 b=q06JVOWH5uUGD2oD6wWfZSLvIqeUEruN2xQL7Xoi89mSy3itQvfjj9vyRJJHH8CgjG
 opfQXvxoc0FVtAU1YRoiyFtoZr2SpR1Y0NT1oF3D4hgdY3CjpyYrqsnFjx7PMTHTy4ID
 Jwu/56jEPKeE4OlcUTV8Te+VwUU7aONSEG8rf31jlAgZos09QyUV8hQofRZ1SvmZ7MJJ
 I5BrZ07YrcJst1/1RXUyfA2l8Qj8awZgQbCN7Jug37Yo/h3TUanoQ1oJHVVwpDxdCvjz
 +Bek6cZaR2sXLGVs6T6ic6fuNezNUg2g1OH0mF4wKOXV8Oimmwp7xKzOLtITCs2SQzt5
 qKAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrH9s1Dib6IZ2jK/Oev6FSwlQytOqsXr5PV7l+mbTuKjO792/wun2Nbe15Fmk+0vtchsr0=@dpdk.org
X-Gm-Message-State: AOJu0YxgEcHcsncwEPsxtfcFFzcUMcBr2FCScZnwIJe20uTqn9WPfjG5
 CKXdMNDznrBiwxz6yyrt2PHVedPmOmSK3k6sx8yEWzDH3GrBL2dyRZTtwSEzK96NUbQ=
X-Gm-Gg: AR+sD11FEVUW/L39uznJv2oIb/7f7in5uphPCPFAPSXlDq79S4ASEkrkyiOp+u3Y/oX
 Zhb5kKrGJgQwgo3Cd9EHEmEpcF2ksc8oo/g7qeZj0vMFV4LxYXf7BqFaRxn/T6TA4LGAnWPCd3f
 xV50ih3dCiivz/8DRHxPuhf2RHuuPcalcuhjmbC8wGMlmuvThdozFiOu2srrOnjfSCweB5kaHTN
 Z9H5w0vQnG5ggTFhN24HsmRlsZozpwTxgmRFfNHOIaKhNlb28QBuDfRkMFxvlRrA7FdM2xeUdbs
 4TDwZphinwqIqKsVWOHoe8zZ+wY44h1Xf1pP5EOuj8K2JgDusstgFX6cyb3Hf/u+74HzvSIiqhc
 06VawmqYQlbgSw7hOKxZHRBtoHaDeH5yWdGse5hNj279wN7lPx25wWMjDjtP7MxysJdl5+2rZwE
 bga5gd2jvrWW6/cHFh5HUpMnDT5SF79YyAmSRBH5++KRM=
X-Received: by 2002:a05:6a21:7483:b0:39c:126c:93b5 with SMTP id
 adf61e73a8af0-3c3ad668348mr26611462637.21.1784744449294; 
 Wed, 22 Jul 2026 11:20:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130cc5ebsm10596243c88.12.2026.07.22.11.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:20:48 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:20:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrey Yudin <Andrey.Yudin@infotecs.ru>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] graph: fix xstats of cloned nodes
Message-ID: <20260722112046.6cf64823@phoenix.local>
In-Reply-To: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
References: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
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

On Wed, 8 Jul 2026 11:14:19 +0300
Andrey Yudin <Andrey.Yudin@infotecs.ru> wrote:

> When cloning a node with xstats enabled, xstat_desc entries are copied
> into the rte_node_register structure, but the nb_xstats field is not.
> 
> As a result, the cloned node reports zero available xstats,
> making xstats unusable.
> 
> Copy the nb_xstats field when cloning the node so that cloned nodes
> preserve the xstats configuration of the original node.
> 
> Fixes: 070db97e017b ("graph: support node xstats")
> Cc: stable@dpdk.org
> Signed-off-by: Andrey Yudin <Andrey.Yudin@infotecs.ru>
> ---

This patch is technically correct, and I have no issues with the code itself.

However, the submitter's mail domain (infotecs.ru) belongs to JSC
InfoTeCS, which is on the EU consolidated sanctions list. Whether a
contribution from a sanctioned entity can be accepted is a legal
question, and not one a maintainer has the authority to decide.

Holding off on merging this patch until there is direction from LF
legal and/or the DPDK governing board.
