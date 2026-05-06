Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC816CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:45:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E90CF4026D;
	Wed,  6 May 2026 17:45:07 +0200 (CEST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42]) by mails.dpdk.org (Postfix) with ESMTP id D9548400D7
 for <dev@dpdk.org>; Wed,  6 May 2026 17:45:06 +0200 (CEST)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so2515517fac.2
 for <dev@dpdk.org>; Wed, 06 May 2026 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778082306;
 x=1778687106; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fndz4FxWODyqSGIn0lYppG6yc0c2FR1pP8+LjZuccuc=;
 b=WL3p52DN3os4E4GadHpWJyr0iJVJl/4f0IDeKedQUyipYAzi2OJiNU5XZm92BEliCm
 khrCta5FDWAm7dAVPizFjfBm8pTyfoiWuqwlqNzmGHdoeahOAo/11D+y2ACSoqOW4ipU
 iMpAUvzLva0qk7oF+FtmZGhi/otBEm34NQCpnnDDZO7Ui3dter+w+NoVP6HWWWZwMuPz
 0UeroNYLs632WFpSVXNdUNkA+gOOrbaXWIvtz5nIUAS3JMvw8nWfMUXFTd40DXiuMSFQ
 bQS9AvbdvOdgDij1okqCb0m1sUuyJiMDi8xIhfpnbgq2xqYPnz3ch2RmAoyaEDUYs+Pu
 yaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082306; x=1778687106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fndz4FxWODyqSGIn0lYppG6yc0c2FR1pP8+LjZuccuc=;
 b=nyzLoHG51EQaciWGjjw1FMdIayhYcOQKGCwe0Zag9kwfZBeyxcE8oneTbj1teVy1mP
 hay35Z78SQ/o1+3j2u8akHNsiFe5L8IwjygL5GZhlUGBjP+kRW6xgkaqIfYlx1McxilL
 QXtU0JtVRYmmr3z05IKrWv+H/hLj2FDxqjU4y0m4HYvPblETqrX82NqfYiCFbdZsDDrp
 BaVQA0Uv5ENsqcONsBKFJ4m/AW9VzwXfKKJLJVGC1eYQcnc7CBdNunx2tWtZ8/KyFOo0
 DH0kCFogNqnCvlOQU78IBysP4RWTeWPugEdqpcv+s/d4hHBNPH36O/lS+/jTkdH3FufY
 EbCA==
X-Gm-Message-State: AOJu0Yzf0Sht6gnweX4QL613PlS5bMLDEcdcjCdy7XjiLgx4dGOA3L6D
 PbRfLWoeXdfttoF8gqLb1x5oGUJvaRcKIPf2ZPnBnWSJl1eZU5VC41jnqsw6FdK+W+E=
X-Gm-Gg: AeBDiescdN0JcXOP6DQDa4U3imgTsEhHPlauHpFbDezI/wBCgBaN83tDs5i/yDRA4la
 fvDSdqS8g4iNmvXSc15uzgx6X/yQbwKp4yFtaZJyyI0+VgSAiL+aet5joeHoUoG4Zzvnt33pKLw
 Ic/frZoCxrh78ivWkrMVgrq9IxROAfWzZPyeeBo5q4MODSk3Nqh7jwx2d6cL48Ae4VQzv1NtquW
 R/Ar62FO8bXOlN0Li95b5F6qb1ImJf2ln8Pt9K0Z3LtYgmMdt82g42Q9GrJehiPpnSrpWEhfNNk
 OpVQ1cQPgEMA2YNYPgek/QH5Er+JnhczRHoprjJw2+2lYrcKPJ7RQRaVzD7RPzlhFYtTQskGzwW
 m/5IlfXzqiF7e2D0FUlEWFRubPxpupoVm+X7aw+SsUZkEBF6RlzxC5G98d10BxkgLL6rVUj0jAy
 hqYW/AJTkz/LFyDt1Y5c6c1cXkeOEZBU3sKKIt33El8s1UCA==
X-Received: by 2002:a05:6871:7428:b0:42b:d0fa:771 with SMTP id
 586e51a60fabf-434f64eb18cmr2497032fac.21.1778082305910; 
 Wed, 06 May 2026 08:45:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d53a55sm16911877fac.16.2026.05.06.08.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:45:05 -0700 (PDT)
Date: Wed, 6 May 2026 08:45:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [RFC v5 0/6] introduce PTP protocol library and software relay
Message-ID: <20260506084503.1c54f055@phoenix.local>
In-Reply-To: <20260506154131.2496072-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260506154131.2496072-1-rajesh3.kumar@intel.com>
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

On Wed,  6 May 2026 21:11:22 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

>   - Fixed checkpatch warnings: removed unnecessary #include <stdio.h>

PS. spelling error complaints about stdio.h are bogus
