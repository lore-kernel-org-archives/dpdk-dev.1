Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2BCAC597
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 02:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B921A40289;
	Fri, 19 Sep 2025 04:14:22 +0200 (CEST)
Received: from lf-2-32.ptr.blmpb.com (lf-2-32.ptr.blmpb.com [101.36.218.32])
 by mails.dpdk.org (Postfix) with ESMTP id 546B04027C
 for <dev@dpdk.org>; Fri, 19 Sep 2025 04:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1758248050; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=T0LHO6IUZwj7mQbiAh24x4NCQU+SUODbrW//tW3So4k=;
 b=iw2Bj5PyDARLZweaSF8GWabbjDKn4s1xRAhmq/0cmpTQHiW8IW4DpMB7OcUxVLAUklCxPi
 GeHyVNxygNFCr98U2v2Ze4FVvF65ujlk12nzF7TWI1YkdG+vI85q4V2mL9eAcwbrWiH4Vb
 GEaYTX5PQt1fWDsim2TwO6Ti7/DdFIGjAlPyxtUI78GDo5a3gBTDvYJiHze42PmOkywwSw
 lnDxM/Nxbpb4ZJ6gsLp3wsEouKxUVtmbiofPOALonQXffSauo2CUvf/x9Rcr5pcOZBurUR
 9UXJ+g8HyRtl5IneBCIE3vZyj6BLn0Q9Zq6zJ2fjJtkSp8NHM/VHqvhJePFYtw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 10:14:06 +0800
In-Reply-To: <20250918085433.0f3017ae@hermes.local>
X-Lms-Return-Path: <lba+268ccbc70+9bd9bb+dpdk.org+wanry@yunsilicon.com>
Received: from [127.0.0.1] ([58.34.192.114]) by smtp.feishu.cn with ESMTPS;
 Fri, 19 Sep 2025 10:14:07 +0800
User-Agent: Mozilla Thunderbird
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <fd1ee24d-91c5-43d9-9e05-391c06fc9eea@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>, 
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
References: <20250916100850.226649-1-wanry@yunsilicon.com>
 <20250916100852.226649-3-wanry@yunsilicon.com>
 <20250918085433.0f3017ae@hermes.local>
Subject: Re: [PATCH 2/2] net/xsc: support compressed PCI BAR
Mime-Version: 1.0
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

On 9/18/2025 11:54 PM, Stephen Hemminger wrote:
> On Tue, 16 Sep 2025 18:08:54 +0800
> "Renyong Wan" <wanry@yunsilicon.com> wrote:
>
>> This commit allows the driver to correctly handle device
>> with compressed PCI BAR.
>>
>> Signed-off-by: Rong Qian <qianr@yunsilicon.com>
>> Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
>> ---
>
> Queued to next-net.
> Should there be a Fixes tag on this?
Thanks for reviewing.

This patch and the previous one are more improvements than bug fixes,
so I don=E2=80=99t think a Fixes tag is needed.

--=20
Best regards,
Renyong Wan
