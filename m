Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85CCD98E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 07:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE281402DB;
	Tue, 16 Jun 2026 09:16:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B999140289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 09:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781594188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcwxFhSX5L/cdiSBuat6Jzxz6aebISIpUZE1NSYflbs=;
 b=D6ipWauoILvuJqSk3SJ6tlGF5JQjYGUh1EUK/NjggCNqZ8SisP+YsEJ81lxmMyOeILrC97
 /z41svnc6Cqs8DzeekJuRGybuw98rSfmvBMh+4Rq2leuHXcCqKXt66BhW2A6UQfeMydjA8
 BnBUoU1PZjOj80bVsVG9PXv9CE8i5m8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-ECJM7T6CMw-Z6RPOWr7bKQ-1; Tue, 16 Jun 2026 03:16:25 -0400
X-MC-Unique: ECJM7T6CMw-Z6RPOWr7bKQ-1
X-Mimecast-MFC-AGG-ID: ECJM7T6CMw-Z6RPOWr7bKQ_1781594184
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso2366619f8f.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 00:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781594184; x=1782198984;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcwxFhSX5L/cdiSBuat6Jzxz6aebISIpUZE1NSYflbs=;
 b=jfmmss4pozajk4aP9q/iYnyktWpsT1TC/p+5nDpTwEr6iiibSYuLRUSeMhQqBi21YU
 zSFv/3o7tlAahrm/3d5mtHeKqTxcimSJmECi68RFMNPvdBWzDQmkYFi5flHmd6Eup/Xo
 7XCFV3E+LCHj7lxeVd5Xs4H/ST6X0R0ybp1OK0u/ipwQw1PN6L6RyjXlc1p+sxeiJIKz
 vRlUbMdNP5GvN+vKY77umNkMX6UbtENvDubflyze5CxAs/PLR2pvMIaHKNE/OVFOuZ2y
 l3sgWTZcD/6t5gYprxjSN5mfRObgFSIA4aR3iXsmkmS488bHSLnZ3+6W15PvyDkIxIO3
 sT1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8m6CQp2z6T7FWKhkez5T6whWY2LldGYbyyw2AGWy2OPTQ2H0iCm4aIM6up5myNAo8F5K4=@dpdk.org
X-Gm-Message-State: AOJu0Ywwv/NOiXZjcDTuyKz/EHc3TfamaAPHcIna13hn3u/l79zQv/ia
 EyxA9ydu6RA/jdS7s8ou1Ld/Qm1eemKjV8SS5ZbjCdnm1kDfMzRWF/t2+2a6/JrQBIPHNmwy7A3
 AnqKMyoxNluDI2BmUhWCVdxyIFioJPHjMrdOg30ipW634
X-Gm-Gg: Acq92OE8jfFy40NWXMRf3GVQor1mGgfFG/jsXYwlaLTOKCRrBhG0HTbtk/XMI6hogNS
 4oFoBC8Sqt2PrH8Hb7AwxImPPJIZJEiNxuH2EqOC6IlKRHJSghlU9TPxV5DMApSFu9EfbTulqDR
 kV24vojir334qdYyLJDkO2HBPyBWJpaWBmNvUgCsdHHpfJdufLJerYL8hV6DKK+ZQIq16AhD1t1
 ftjrL1QfsrDqONmUg++7D3cS+OFkkkXg/BveuE6ytXjz/5QoZ8Gz/rK+U5umdibniKoDNUkLq+1
 5dF3EirNkKeN5KyKTE7YQvonaz31aStQga8TrEu24RWxFRFWiKA/XE/ZuoEhvkWKBsrc80w90W9
 MD5dJ7I7TsgZKKvwCE81yqmyEj+plvnxEAMoqhzV0Uc8wWh7eDnrboOSq0BM33tXkcMJAxlBR35
 BhV+8=
X-Received: by 2002:a5d:4912:0:b0:460:7300:e91a with SMTP id
 ffacd0b85a97d-4619f319158mr3213893f8f.39.1781594184238; 
 Tue, 16 Jun 2026 00:16:24 -0700 (PDT)
X-Received: by 2002:a5d:4912:0:b0:460:7300:e91a with SMTP id
 ffacd0b85a97d-4619f319158mr3213837f8f.39.1781594183706; 
 Tue, 16 Jun 2026 00:16:23 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm37306408f8f.25.2026.06.16.00.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 00:16:23 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 16 Jun 2026 09:16:22 +0200
Message-Id: <DJAAFGOSALXB.3BJ91NA2ES267@redhat.com>
Subject: Re: [PATCH dpdk v2 2/2] graph: replace circular buffer with
 priority-based bitmap
Cc: <cfontain@redhat.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <konstantin.ananyev@huawei.com>, <maxime@leroys.fr>,
 <ndabilpuram@marvell.com>, <vladimir.medvedkin@intel.com>,
 <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: <kirankumark@marvell.com>
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260519213822.735891-3-rjarry@redhat.com>
 <20260616063026.2007191-1-kirankumark@marvell.com>
In-Reply-To: <20260616063026.2007191-1-kirankumark@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aY2cWisdit7C7ELp5K_HswMX7pflZ3OSOqbgSoD-uos_1781594184
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi,

, Jun 16, 2026 at 08:30:
> This will break the ABI. Please check and fix.

Yes it will break the ABI. There is no way around it. What did you mean
by "check and fix"?

