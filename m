Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE65CD98CF
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 19:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E15A540DD5;
	Mon, 15 Jun 2026 21:12:20 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 57623400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:12:19 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-307d0405e07so5640370eec.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781550738;
 x=1782155538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUCBsjL6RZmUYaL5Ync3yd/QM4a7IsOfEI/d1CkNlsc=;
 b=EooM8Bz605DChah/G6K/6i2MSE5AdT+qIwVx8InnglqSKth9f9fXhoAiZU4zlJFhq5
 KT6Z8AXJ51vEFiKEdVSjD8uTRRjPbK38iNsaxd1e6RweY8qILooFOUK1wMVX5rjdeTRT
 zUqGo7Vp+ZkwnWsgR9ng9oSu3+9MIVU7RlRac/iPm0DgRcrUfoM57C6LRbXrCBsE3VwC
 OORVlWCA0m5vEBbqEqTuUangRIoALXd7sXSUefb/8p972QmRRaQLwKvXduQO4HCThxrI
 U9ao8KutIBciRskhIupA/F880KOf3JZeEG/TkDxSaYSdoVZCmXxw484mSg2GVYswlLUY
 Me9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781550738; x=1782155538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iUCBsjL6RZmUYaL5Ync3yd/QM4a7IsOfEI/d1CkNlsc=;
 b=RS9AzzS/Pzf4410Ma8OkjVrsPd8VMWsT00iA10nZtG6YbMxspyM4L97E0+bPplIyZc
 JkU9zyz/pjrYtzqee7vOnz+bHxGdkBXzH93teBCaFcSOnZJ2CBnXKfmFr8kTOoGueBOP
 TzhWaMWCl/oYyWEbakC71mk+UTOfcyVtqJUM5IL5Ca017wBsQo5axkueGgRN+M7WQ62Y
 iShilVCtEBz3Fqqhaci0/JCnyzHrHXM9UsipflBOI9/FR9mrgSYBwKDRqSl+csVoRTHb
 YVQy8259ME+C5tfLuYXJTMSzQNHM58nlOpDVwh7wxK3+VkL6aP703SaRhpr5HgLoUc7j
 qXsQ==
X-Gm-Message-State: AOJu0YyH4T8dc4+VjXOwvAljiWTs2BRvDV5IiAZpBSAumdVHdNLzlI6X
 VR/t7JiNkk9l50milkKnb7skgYOEkO+vnQWUr3c4OrvVxbLhdZZJHx3TMNfQk9JCOWQ=
X-Gm-Gg: Acq92OFfM7nx+rhKNt39lb2lXDMyRvjbIxydjynacYO/B/LMnK/r/LsdCPN5D+LE0zd
 Bi2+37Aqx1VoVkr8C0t486CCiR6dcO56MrJz8cWPb4ABqWEw1ggve1/tS2gNEQwgZiqRI03pd/h
 BKDSQCo0j5sv1vyMyXOcjVjKiugXa2wxKe77F2zjr6tigIEM5RV6kWECxJ3tD3KEX1bcooTvNUi
 KrP5fAI0OY2VFnEtbJHz9ZEn5so0HplKvMidUY0ezx/kowCsVgrDMDfcf2ED1dhgmt9BSL99tRA
 I/Kwb1r/WPisbCTNiqXHmSRU0m6MEOhNXbRWtg3utemcQv+KXm/yvy1C1RQa8etp6JGGr3CPl72
 KGjZF5SLXnvWXm8fBfbqcjkzPs0/dI8cajBIG6OfE+oHSsLzYQb8hOYUq7wAPuW/Grb4wis6QSP
 OE6psSDOOzFwr8dTaivzQkGmjQBrBzWOCqceZ5ebTj8QxinSBKUgzvDeG4KarKxJ5d
X-Received: by 2002:a05:7300:640e:b0:307:43ff:f32e with SMTP id
 5a478bee46e88-3093fba1d77mr6404487eec.32.1781550737851; 
 Mon, 15 Jun 2026 12:12:17 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d810fsm16243417eec.12.2026.06.15.12.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:12:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:12:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: add VLAN priority insert support
Message-ID: <20260615121214.6fb7d8b7@phoenix.local>
In-Reply-To: <20260612081411.2798403-1-yangxingui@huawei.com>
References: <20260612081411.2798403-1-yangxingui@huawei.com>
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

On Fri, 12 Jun 2026 16:14:11 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> The tx_vlan set command currently only accepts a VLAN ID in range
> [0, 4095].  This patch adds support for an extended format that includes
> 802.1p priority and CFI bits, allowing users to set the VLAN priority
> tag when inserting VLAN headers in TX packets.
> 
> The extended format is:
>   bit 0-11:  VLAN ID (0-4095)
>   bit 12:    CFI (Canonical Format Indicator)
>   bit 13-15: Priority (0-7, 802.1p CoS)
> 
> This is consistent with the VLAN tag structure used by
> rte_eth_dev_set_vlan_pvid() where the PVID field encodes VLAN ID, CFI
> and priority in the same format.
> 
> A new command line option --enable-vlan-priority is added to enable this
> feature. By default, the feature is disabled to maintain backward
> compatibility with existing users. When enabled, the
> vlan_id_is_invalid() function allows any 16-bit value to pass, while the
> full 16-bit value (including CFI and priority bits) is passed to the
> driver for hardware VLAN insertion.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---


Having ability to set priority bits is good, and testpmd should allow it.
The mbuf vlan_tci is already a full 16-bit TCI (priority/CFI/VID), and
the TX insert path copies tx_vlan_id straight into it.  So priority
insert already works; the only thing in the way is the < 4096 check.

Do you actually need a new option for this?  Both of_push_vlan +
of_set_vlan_pcp (rte_flow) and "tx_vlan set pvid" already let you set
the priority bits today, with no new code.

If you still want "tx_vlan set" itself to carry priority, I'd suggest
a smaller change: relax only the TX insert validators and drop the
option and the global.  Don't touch rx_vft_set -- it feeds the VLAN
filter, which only takes a VLAN ID and rejects > 4095 anyway, so the
flag just turns a clear error into a confusing one.

Either way, if the option stays, please document it, and add a release note.
The commit message why the existing paths aren't enough.

