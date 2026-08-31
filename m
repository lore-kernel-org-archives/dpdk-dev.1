Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A7C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39BC2402E9;
	Mon, 31 Aug 2026 18:19:35 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 402454025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:19:34 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so4104086b3a.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788193173;
 x=1788797973; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KeIi5RFZ7YLKppnB4+wK46NOzCOrrYfyKdppAIihuPo=;
 b=zMeYp8gWnNuQpsF5jDh4N1XFizdUkYIPFyVU9LyH+CUwinFgZJOwD6n+vUoy5fqW7J
 YN/XbGntUN3dDa33Z1fhDs81kkx2yMJt/KR4yS1zQY1Qg/wGAdzLCsCWrb9Kdsr0td41
 +9pymzg9JXro1x5GBAfTUnxqwheKHJ075Ai7fp5JQ0IIKeDXCxvCUQr8gCusjUHe5a/c
 YnUTNkOfuha9vXfgWx1YzroZVDuPCm5Euv7KCTchg7q4eM/x4bKBG1hm8odTp6ykYlvj
 JUE6Y58TWLR3bBZ/WjB5FoVopsXrbMBXLZHfG9ks3fLEUWZ1pIhQWQtosygjFvoz5+Gi
 xGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193173; x=1788797973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KeIi5RFZ7YLKppnB4+wK46NOzCOrrYfyKdppAIihuPo=;
 b=DQ8Gi9hAFWiGRFBo264mxWNB/7bl+fGUBwwDriSCOgtfeirfy9kJLFKlmDCEl24cFl
 77lt62BjrUyj1OW2JGRHKqUf4yKRbT7QkNd7uAQZvtdjpb2rvh8KPAQl1kEiSfBtiqj6
 IbDxzuiO0U1H6/hA8jbZZPGYsMODNP0q7zPCnx6Xe3Khfbk9vn3tXqLq+3QuqFZOrttq
 yMxAtNRVPjVBGlEfnYcYN1M6SlijJMcalcfjtXppxS8PTQFK9lgAO5C8HCzjzss0Oog0
 fff/LDjyP7b5/USbZLKHnQTbMBiYrYKBxG6y98W8Dig8T687hUgpDE+GKizriWIFlCRX
 KXdw==
X-Gm-Message-State: AFuF++lfOI1Z24lQn2FIiEnc/4eBdTEWUkBjWrzuS1IJ35fTWAO4KUvp
 Zv4t2BNrOpFaAcDVY0Qla5SrqEMhOLESa/aB3jRirwZgYorC6UT/kcSSqaOUSHffststVuctIW/
 G7b0L
X-Gm-Gg: AR+sD10sxJEA/e9lLe2tgOujj26IVAhFIUtLM6b3m+t3pckktAfEp1Yro4xhZdUhB55
 8N5egYzbzko5Fzspe3C5x8TusCWN21sGh6hZONzZdcVXdkBNVHMkG0suxMg1K/+FWo8DJY74WfW
 Nr5tkMAyjE+EleRtf1KYwsHAKm8sdFB1j6NDFfl4dUosLBui1R7qiYrlqmskNozCdIpz/tH9Fi2
 dE1R1niteufPw3ThCwr6Rcf3BPkUIG7PwMRo6DLf3i2vGCgvvg299qxysEADCpSacshKrn3D1rm
 2ly0MYqiCRu3jF1KN1FrzWaSay4WP+3ymuHRPv+VePEur2qQJiBXCDODwAVjYbR9fq1vEQxdw2K
 R/Ke8XRqsEceR/HR6KNyxhXetotP+aq0HWbBEUYSVOcJygIq19xkAtBQPsYNph1Oxor0SkrSp2z
 Up/hupe4Xuv/o6qb62vUWPoc/Hnn3a95lplQiQgYhOY7J86CDw5lHxGkoL3bVJ7r/CyMVwBwoN9
 GfjiLRB/VpL8xSM624SCdtnwPOAQQ==
X-Received: by 2002:a05:6a00:3397:b0:857:727c:a1f1 with SMTP id
 d2e1a72fcca58-857727ca41bmr29576344b3a.19.1788193173354; 
 Mon, 31 Aug 2026 09:19:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a2ea740dsm3987925b3a.35.2026.08.31.09.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:19:33 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:06:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 1/2] stack: introduce pile
Message-ID: <20260831081522.16ffb8b2@phoenix.local>
In-Reply-To: <20260827135556.522443-2-mb@smartsharesystems.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260827135556.522443-1-mb@smartsharesystems.com>
 <20260827135556.522443-2-mb@smartsharesystems.com>
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

On Thu, 27 Aug 2026 13:55:55 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +__rte_stack_pile_pop(struct rte_stack *s,
> +		void **obj_table,

NAK to using always_inline on a function this big
It generates worse code in a lot of cases because of register spill.
