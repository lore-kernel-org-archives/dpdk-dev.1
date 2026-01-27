Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAECD25934
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 05:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFCED40B9F;
	Tue, 27 Jan 2026 06:11:12 +0100 (CET)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) by mails.dpdk.org (Postfix) with ESMTP id C3CE140A77
 for <dev@dpdk.org>; Tue, 27 Jan 2026 06:11:11 +0100 (CET)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5f52b0728ccso1772701137.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 21:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769490671; cv=none;
 d=google.com; s=arc-20240605;
 b=U7OSBUBrWpI/lBOPf0VjF4HjQGJn8Mu5ORHVRAb91w2n/Odmb8er51uxx6IfL9CnBN
 xrTUyvKdYIp00iNI3wc2Jh1xWXaOM04+9CFHujbi20u6jLFT7Y4srQ7a3eZwXXvYUqEb
 fmnwtH7aVseemmI/nDzC4/fy/HztGJM1nEYP7JhAvrL6Lfi8xrpV9KHNLY/Td8XT4xkg
 5oqP+4W6kUtSlDoNp/J88mKbN7YG84pvnSQWS0De/HibFQURH7F01zWZMMDtTki2+/r6
 //ocZkVmM61JNxEcyw9PpTPFuwPJdWlyP9qANNZFcrJg8n4RD8SD7JvU/8GSktNDYfzl
 JcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LQie0P+gABv90fHZ3vh2EbkIYA/NbTPr/SVVKV0qN3w=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=F6QsL4z7JRS1Ld2WoIU7hxbb90e4f66zjd76T0nlB0HbhV5pAun6CA8QdZWX7woFWA
 PJA+aoqp/NgBikQDw+lp+03uhfrJl7aQPObhFi+sxxcVSqCnCYmKdYMyfyUAAw7Ay+MY
 W0uBX+/9UP9+YLXeE+RwUgbh30tbwV2tTD88VeFuFPL/JKcFUV0GsFvamMOuvd991biK
 ArlB/fRJPyxvyjtkeOxvIPQ/KOQzceG+7DD0PJMFTFBHdsFCII+6cLc/L4u/p2HM6Gkg
 fmpp0/dLT4tKmbPNOTriyCnnl9wonVnRJCodSnwHfMdIJdfY1IU7bebx/6e4Uyg4eTeQ
 DnvQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769490671; x=1770095471; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQie0P+gABv90fHZ3vh2EbkIYA/NbTPr/SVVKV0qN3w=;
 b=aN49LzMwuYZJmqkJx43GEomsY8ADzmBUAO6cwjcdoEgMSlhptkylSHswzr+byPOZzN
 oSeHkIaxXuauVLoMG/AP84JDUebyeJLlm3YmFtcVhJ1swecU6JR6dxEJSTBMBgm+7oCZ
 0VAFxD58X4fFCBFORWdTNc0lXt2O9skzpsAebK6CUmXDBV+KCZRbkDNsGIaNAjhPyehU
 uV57qRDJ7CsROHoI5wr57nJbDGqvN7aMqX727JUUU+7jPXo2vVGdaGkYPP39P1XrS37+
 Zok663IoWQrlVfjCSTXs+tcyxZBv34IGFAQ5pYaaWAyU7F5LDsNht0nr0ES9pAp0qdh7
 12oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769490671; x=1770095471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQie0P+gABv90fHZ3vh2EbkIYA/NbTPr/SVVKV0qN3w=;
 b=Wg356iw1tvWDs4G+2BGz2k7GhjkVGu71K+vbbqNrp70oGhVK7jCjaj5DGz0YNUif7p
 F29YbXL+QJECnbFFtSBYaw09ep8lABbroOUeQ3jKU39LE5JYYCijsUflcxOrV8mxttPQ
 n77JkqksFebrwCcBngzLHqRSQsXEsc/Mw5V68M6P3/J01gCgtRnkzzwcvIOMQyDaxM01
 U9gQmZ8TU4J6KNL09Md/MsN9yi0v9eRmKSN3Uug88Fc+g1VFCcr3uztIrQesCUx5xXZz
 wU6VWMEonithIVqDmkw6YyYP6MN5gmPDmlW/RvHYLMAMbRssq+bgmPYnjbJYxUO40OTn
 d5tg==
X-Gm-Message-State: AOJu0YyrCNjYy1zYoaybjgtKHzalh5Lwxl/VwfQDvqFXeLaZh9n6EJX/
 41fUFtdDNbG/XP3Jwn6o33Wz/zIxOjzpN/PnY77DSAyJ/G8kCGkaeuxLjcRXezwwfJTvPX/524o
 p/rvrCq8lDjowpzIZWDc0C7BSTevp1t8=
X-Gm-Gg: AZuq6aJAZdhta38WxQY6pX1Q0FMbKuHLuSJcsAJAtdWuj4DdVOR1EHzEJ7bzmIG4tpL
 +t8OO+sJqX2Sy1GdO1k5H1bBSAXWRfK+g/aXQV5DhYBvLI0tqUhZ4RapKDoxcaIkhiANoKdBFl1
 58c1VBY8beAnpW7Bt8rjHNgk6pKYKaKBKnNrH1AUke1lsNyRuqoV+ChFO1nynJZk7mT/QfBGGiu
 SyHXe8GVlrfCufuR54/WmEs/zUZiCJqpYxv0pRWXIwIQmV3v3IQMmZiycEAUFm5cnB6rdY=
X-Received: by 2002:a05:6102:6ce:b0:5f5:4eac:cd2e with SMTP id
 ada2fe7eead31-5f7237c3c83mr443958137.32.1769490671001; Mon, 26 Jan 2026
 21:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20260125223015.69190-1-scott.k.mitch1@gmail.com>
 <20260126080328.11567-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656B9@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656B9@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 26 Jan 2026 21:11:00 -0800
X-Gm-Features: AZwV_Qi7DK_iWE1_FvBXvbKFnMMBv2U3hbvW-c85uxXmPHG1N1QUdLeoK-BmMUg
Message-ID: <CAFn2buApHE3LfA1fjqL8rkAJULhXkTDEmWWdwNHoFOmw5TPK3A@mail.gmail.com>
Subject: Re: [PATCH v14] eal: RTE_PTR_ADD/SUB API improvements
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com
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

> <feature creep>
> If we decide to proceed with the RTE_PTR_ADD/SUB macros not discarding qualifiers, similar RTE_PTR_ macros should be updated similarly.
> But let's cross that bridge if we go there.
> </feature creep>

Is RTE_PTR_DIFF the only remaining? There is no difference in assembly
by casting to uintptr_t https://godbolt.org/z/z77nEr6Ts (I assume bcz
integer return means pointer provenance isn't broken). Native pointer
types will throw an error if the pointers are not of the same type
which can strengthen type checking, but similar call-site analysis
will be needed as there is mixed usage (different ptr types, int + ptr
types).
