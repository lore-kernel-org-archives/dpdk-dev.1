Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4537AECD9AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37A8140264;
	Fri,  6 Feb 2026 02:04:21 +0100 (CET)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) by mails.dpdk.org (Postfix) with ESMTP id DD02D40156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:04:19 +0100 (CET)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-5eea9f9c29bso122782137.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770339859; cv=none;
 d=google.com; s=arc-20240605;
 b=M4qd5LCVzV64qE+/xKGQJsvwFSpLbwAThNherWpO3KN/GFLPn8lvlls9F5ZwQAMcsj
 LQraYSvC9phwU6s9YKh1mgq5AzinDysEPFn1Vuou5e8lgFlpU8eZ3SFxtGnXGPHXF1dI
 XLByzxpwLKia0/aSce4g+ZidChLYmbY83q0K1ulArYq3W3cB7OEW/9W5HCfjvr5mLDe/
 Y2wrraf0QQsPcY8oBWib4bs3C61+9BCivm51IaZmagVYOS4nAXLYpWvUN479oWhRi4m5
 dkVgL/pdqrPdZJOZ+w8L4kTdGQIeiVkN0Cqw0I1uye2qamKRu1MbdDMX3jp8sG/qOsp1
 aNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qhS7nh2Y4NqUn4lsn6kJ4ou1GkYaqPnEaqdOLNSyLUQ=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=KridRQ+Nm8fxs6wMLQ4VCi0KAN/u8RTDklnbv6esdioCI46G6DzdCltnWyceUJJ855
 Qb140gnNx5Mm67iwhJs1GhIhM9rYyHE4tUEsg8heUAplZ19NKWGV91YUYWpYPD4f+1/l
 BL35kgE7YjdrXk828ku5Q4bUbSYLsFWF92sLMqEb7AgpeqkPxJFkapBMVf7ImI9EMT/r
 jVslSB7bwz6/9u9Uv6o8yXc/CHcKzxHqnApsZnhsh5U6yjowErN1aLGZzm0CV+ZnUKUN
 dC/a65J6Zv+iXbJXO80z4O1GqZhcOQnHEvodESev2TW4Sk0vuBTDTklbPfauCT1dQDyc
 huYA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770339859; x=1770944659; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qhS7nh2Y4NqUn4lsn6kJ4ou1GkYaqPnEaqdOLNSyLUQ=;
 b=N4bHCZ6TRzUnq3Pyeo5w+hb5oopRxgxYGCKY5QS7hSMgWEW3643Gc1Ugn2P82+f/el
 ucZlTPFQDuu2Uj7nifbwUL3ZLEv5mli/fauHox7R/HLvxQEzgTxnPerrjHTxFGW6MV5I
 8y2uGIqRsluRTV7P7K0AeGTvnkJZAbSVISzxBSPyvuxA+ulRceKG7wIkP5W4K/LcLpA1
 SaV962GGbGrJV3C+mcpLH0Dot0W/bHwLW8Jan2BGA4tqUwXhNVPqszYj0pqM6cl+wWg0
 JNkV1STPqXSYNbMF/fCPnXEKmvVLnI4IcvY++Fi98tn2SpyZ3kGtSDG5GbZILaMsynJ+
 xqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770339859; x=1770944659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhS7nh2Y4NqUn4lsn6kJ4ou1GkYaqPnEaqdOLNSyLUQ=;
 b=SZz7m+hL/EKHadcG15kmV1meO7HWol2UmE3gRIGxmga9JUHimQcUR4B5Tmk0/RVmQT
 LAs5rMqKq2lBG8WLmG9yXP3ZvTsGn2u+jZOYWrwHl5W/t7Lrw1USPqmTryLbTYSZERTK
 3UOyS72MOqoA7NAcVRus7z7vvlpnrg0qg0LEKfiPe8i2q8DOCrIhV0KZtbSAbRQitV4l
 k8GOnw08guhTsA99I9l5iRI9/sbRFJsSsekxeyZPZy9mDc/TdndmH1PsJInaxbhghp2Y
 mWcWmgpj42AXQrFRtn+8m1LX9lCRtiA0Jo/PMAjxXOw2ayXnTyntZ8adGVjcHPdCIx6Y
 m0oQ==
X-Gm-Message-State: AOJu0YyK7tCt5letEieGqVsJXkdQwR3uxsPS1YxSg0hkMTS0p2VOaowF
 DoDnNZCY2kbgmerllIgTdbEZ86/L4J2697t8h388enMBhbh2rCLwRM0DsG7Z1xTKNCNWNqbAS4h
 BFlpci2ty/70xfy9FR5EZvyGzIUel+Dg=
X-Gm-Gg: AZuq6aL/6/OV+ouaBZxmtcuulXLGY1kTj774PqSUrJZhhVdCaMTfUU5EDCLg/tcT9K9
 O1uzyFQY1O6VDDOT9qhGxr5NVyNztgCjjlzRkidILwdZQBDUcFhCYsQIxGIp7xaEWFPftgX7oIA
 LmMEL2b27L1B529Wp60/1RbVaiwurOr5CLnvfen6VjcBFLSCqzCeg+iLpv8t1XalLhj5TQd+R0z
 f0krRawAUTbb2ISCZC/rFTzCI2j/Dc2toM3LmrObYSQIhz1RLaXm1esCwayC7dI05QFNfD7HQ==
X-Received: by 2002:a05:6102:2ac4:b0:5f1:9641:4f2a with SMTP id
 ada2fe7eead31-5fae8ab345cmr286507137.18.1770339859182; Thu, 05 Feb 2026
 17:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20260204061234.25610-1-scott.k.mitch1@gmail.com>
 <20260205070345.23483-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656EE@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656EE@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 5 Feb 2026 17:04:08 -0800
X-Gm-Features: AZwV_QjTwdnTpMahqIVWtf6UpLcWXfHOkkBZCuA0NHAsWXR1y7WAay6y0GQpw4c
Message-ID: <CAFn2buDHQfM+9bNRhE6wBGPCXn5nypysPKL5-qpcjVfbcn+CXw@mail.gmail.com>
Subject: Re: [PATCH v21] eal: RTE_PTR_ADD/SUB API improvements
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

msvc build failed. I missed a cast in RTE_PTR_ALIGN_CEIL return value
of RTE_PTR_ADD, fixed and v22 submitted
