Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C24C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 19:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A85614013F;
	Wed, 16 Jul 2025 21:25:09 +0200 (CEST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id CE485400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 21:25:07 +0200 (CEST)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e82314f9a51so240006276.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752693907; x=1753298707; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HH0kDhv4W66UExIVfHl9k46Ohw37DSDcg+WKDECCVoQ=;
 b=NCB5fJMGzOhpTu0cfSIcZaDzNzoiq2lpJmYd4xFAlyQ0rFvyT6LIaEnbIdA+oL3vRL
 7ZDmp367ZSJfpEo8SPOyHA8f12CnCxhT7WKOciksmlEcUN4Gf1cM2PmN2hkUdos7Sv0M
 ACZsB677SXpK6Cyx0jdaEQJa0sD9Qunqy61vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752693907; x=1753298707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HH0kDhv4W66UExIVfHl9k46Ohw37DSDcg+WKDECCVoQ=;
 b=KUC+JRNPjKu9bJ2me6pIquJNg3UtBOEMndS5Eyiw0Z3HhPjy2xt3LBJuHq40+xTcL5
 6xLdBYUXRjJ+kplW4Tuw1ue8r8862snXN+lxAM6WOj2XXOWDRIRBQ4g2pvZNQOhTJER5
 wprNsw2tmwweGuyIAu6uStbpc7IPXZF91gc+5cN8/hcEVT2C+t1XuLQwosXXk6d5YxJi
 MTZh6ymH8cuNifPxefde0v1qz0b0Xux3vo6SRvvnmc07NKAreNRgCMnh9hCeh/uWqIO4
 01D+xOsI4p73bd/uXZXzCIWBc4Dg6EXX0DhZKAndlOCQGvX63CjN1UETHJ7F+ebCQiEK
 1mzQ==
X-Gm-Message-State: AOJu0Ywd8yu99lUZPvamp7KTk1RLYHE9yW4waZngaBPtsTbq/Jg9oEWB
 KHhbLp6paddCC4UzVRflESehkyYddKx7YA8buJBCZTvK8algsecPAZg26b5iX2WfUOODEZ6SNsG
 EjR+wN/DPy21Ib8MbBDJ4ZGYWRXmucBqM+j+cY4SXJhApcSyMarolKSo=
X-Gm-Gg: ASbGncufrj3Xh+b1cuCpMR5RsNIY23l5V7KjorQp32jDYP57eLjjhyzWgU3AOep6K6R
 HS5Da9kiIw6iLDOT9/wS05dnTQjunRYnikdgpGroggOZiRVN17tAVG9iX7MO5VIGRMaQxZnqtq1
 z8HkM1HJWb0Qg9qQjI1wVlPlMtJyDfgoDn+8j/KWdNBTZBJVDc46knefL+lsyCeYfKraM+KvtX1
 SG2NRFQPg==
X-Google-Smtp-Source: AGHT+IGIczU8TNciFSmIbUICgFhbIvfm8SvkFYh+260YJWpyBC0g2p/C1HMTQ7TtGGyeKAlosScaWmCt4JbItQBCcwg=
X-Received: by 2002:a05:690c:4493:b0:715:952:e8d1 with SMTP id
 00721157ae682-718a9798fb2mr2060497b3.20.1752693907117; Wed, 16 Jul 2025
 12:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 16 Jul 2025 15:24:55 -0400
X-Gm-Features: Ac12FXzn2R7Uvbi9v8_b4qtXsXgeM_Fdqrky8oeomosERkE-bhoj-4Me2Pp3vpw
Message-ID: <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
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

I've created a list of test cases which I'm planning on implementing
in future QinQ testing. After talking with Bruce about some Intel test
results earlier, I've got a solid idea of what the expected behaviors
are in five of these, but I'm unsure about the other three. If anyone
is able to provide some insight as to what they believe these expected
behaviors should be, please let me know as it would be immensely
helpful. Thanks!

Vlan Strip ON and QinQ Strip OFF:
1. Single VLAN:
    Expected result: VLAN Stripped
2. Double VLAN:
    Expected result: Should strip outer VLAN
3. Single 0x88a8 tag only:
    Expected result: 0x88a8 tag stripped
4. Single VLAN + 1 0x88a8 tag:
    Expected result: 0x88a8 tag stripped, inner VLAN untouched

Vlan Strip ON and QinQ Strip ON:
1. Single VLAN:
    Expected result: VLAN stripped
2. Double VLAN:
    Expected result: Unknown (Outer VLAN stripped?)
3. Single 0x88a8 tag only:
    Expected result: Unknown (0x88a8 tag stripped?)
4. Single VLAN + 1 0x88a8 tag:
    Expected result: Unknown (0x88a8 tag stripped and VLAN tag stripped?)
