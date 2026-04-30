Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B5CD13D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 16:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94CC4021F;
	Thu, 30 Apr 2026 18:21:41 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id C63BF400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 18:21:39 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so1307269eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777566099;
 x=1778170899; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZ7ub/7JApQJnuWiieTDtKDOdUAlaZFl9Pg01TFPJK8=;
 b=fGtJDDFBrDGxXoZ2rNQ7TOkBg9niH5VArIvxK2lXQmosiVIpVww7qsABJp86xsgZFc
 L2wZ43p2tjl7CetnFb/vv/a4M98YExzdD1loxCv+vOUwsfX3pCGpaOwBcwi6K9FH3OG2
 s8Y6/uX6kUep8NBv3PADsem6UDBKx+nRyyA+NMUNENkkiwcGFyivqp5rTSuN3dnxSOhk
 DDAlXfYPZ5LmOnltiJ2A9v7CwnjuvQ3fxE4VAwro2Ci0PVXAT7+ELdklQVJjeVCT5Vtz
 q84sEdDy87YnEYC48uQIkgHTNbZ2pWjpcPhJDO9Sm2FSXYCpEN99NDn/J72+jFANO8XJ
 nZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777566099; x=1778170899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZ7ub/7JApQJnuWiieTDtKDOdUAlaZFl9Pg01TFPJK8=;
 b=gF20EidFXQNmZ4JKzQq3Q1Js/NwZ1fxUxbKyPxEYeFphe010Q3VqKYEIA7XqPTksj6
 LqOiyyvbzL4VhU6q89h7/K0XUIfxfXf3dZ/1aZuvKSugNzsKYyK7uVF21EsmGE7i6pQ+
 903yzDRhULJZzjPx2nyTeqx+t/saFe5jpTQHfMJuG7EQKOvBJabgwrVRB+QnIK4IBOL7
 MVlOGfqXmDFV+v1yYoirrlFDLIIbs/IEmv0b2pvxvbfp9s4rmXa70Pmg58EAe9aOMx2b
 i7p6htQ0kDOqBH10p4blLk9lD6so6/h4Zwe4hBueFJaK1cmxEtNbL3O/V8uoTvjmvSf4
 OToQ==
X-Gm-Message-State: AOJu0YzWFCFnFuqsHYs8k7oMLik1BDgRcf8AsbsDAJ9Ajgc5dtJjFoZO
 dFZlFTob8HmUmeJ8qEHfBzcNyA1DtrDf3D1LJ8XIrASEjpouR66fiKgiuEmf5kmIBIyZOLAZc+K
 ADT1L
X-Gm-Gg: AeBDieuFTUcVwAcFhsb2gdzcEZKhl260k4D56L7ZoPMrJYmwkMXK+ryv3hstPmFi4EH
 a4lL+txZAFV9+SX/qk7l9faCE1FkcfxsHP8Y4/ijczFvCFT/5LKVg5o2lvqo+SUQcbI1uuEZpbv
 bV5phso01kPb9B5b0ejtGxTL8NYAH1V1+20lBBwt2N20feQWJALu+T6GUR7z1+ty6SYFbVv16Y+
 LiC1t9BUmlEqDkYWOLHtol/nxtykYT5IYVavoMHxnvOPdQ1rvY+GgJAbG0NuplxnQ2NDJV9OMiE
 tbqVu6DYVseBCl4XKr5fFQDHysNQoJ6ViJ63TlqxGMm7JGF17whldsTzOUY9xdrLS2o72+gUJaD
 U2NhvkJp7CTlJqZ3w1/otNaAYBgkDTrFvmHSda4eOvOt1SBFWKR1q92pHbAxwFmzDDBdyVBbmfk
 0dUSFamR5OcTeoEo/UQgS2EneVOlXUYDP1Zwx99h67WHSeXw==
X-Received: by 2002:a05:7301:22a9:b0:2d2:c60d:4fe5 with SMTP id
 5a478bee46e88-2ed3ba11365mr1999928eec.6.1777566098376; 
 Thu, 30 Apr 2026 09:21:38 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3537d300sm838714eec.0.2026.04.30.09.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 09:21:38 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:21:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/9] net/sxe2: added Linkdata sxe2 ethernet driver
Message-ID: <20260430092135.4bdc6e0d@phoenix.local>
In-Reply-To: <20260430101819.4094628-1-liujie5@linkdatatechnology.com>
References: <20260430092231.4068642-10-liujie5@linkdatatechnology.com>
 <20260430101819.4094628-1-liujie5@linkdatatechnology.com>
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

On Thu, 30 Apr 2026 18:18:08 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE PMD, 
> which is a Linkdata sxe2 ethernet driver.
> 
> V3: Addressed AI comments

Please limit submissions of patch update to one bundle
per day. Our CI is a limited resource.
