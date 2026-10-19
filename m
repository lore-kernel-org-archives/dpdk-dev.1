Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD1ECCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 099C64064F;
	Mon, 19 Oct 2026 12:36:37 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 6FB264064A
 for <dev@dpdk.org>; Mon, 19 Oct 2026 12:36:33 +0200 (CEST)
X-QQ-mid: tivesync6t1792406155t41c8d12b
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.227.112.73])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 323450369876519352
To: "'Zhang Tengfei'" <zhtfdev@gmail.com>,
 "'Jiawen Wu'" <jiawenwu@trustnetic.com>, <dev@dpdk.org>,
 "'Jiawen Wu'" <jiawenwu@trustnetic.com>, <dev@dpdk.org>
Cc: <stephen@networkplumber.org>
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <017d01dd5b7c$dedc3a30$9c94ae90$@trustnetic.com>
 <54095ca6-afe3-4c28-bfce-4456d9e30e4b@gmail.com>
In-Reply-To: <54095ca6-afe3-4c28-bfce-4456d9e30e4b@gmail.com>
Subject: RE: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Date: Mon, 19 Oct 2026 18:35:54 +0800
Message-ID: <005101dd5fb5$9e9e80d0$dbdb8270$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIhEhBpsi5gR8a3B/C44cPCswcvpAF2PrlcAff/1f62YdRucA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOzJFk6Ub7Xtrgp/o1OhewyGCWl6HY82870z8reYzKduSlxIzK5YM8xZ
 3RwUgZv6Xi7h72M3QbPxcCRrq0OLr8tZcheNYqMQv56Uhl881GmOcFEDUQMGqqFlxb1JosI
 VNaCXFfx8qbHN/XKVZfW6yWF9Fqd1NPrMVyu4bbA/wBuClIBpzRVNbVR59trbvR/qL1eR4y
 E4Q2ZjNX6qmstCFgxpdDCrUDXRS03+bL4MFiNgivCpxzUM3lKeFmLmMjlrhVT+1cLoWmliB
 dVKNF/ad9EdxG1Oka/EP/4+9wipiprCy/t2usEUhQmZ1WZEmMDse+5EHX7ww4wFeIpqNkql
 UsqEPltjvXRgoUgVjzm/NAHiP5F25qOPBEtYL+6ox58Dt8PyvLQ9olXfv4upAMMJQRsfTmg
 bT2F+7dWyLMYN+C0z8kGlKIkWH13IaiOyMO96z7C/ivl40uQLDF+40eY/V5UW+AMZpvyvMR
 3CdhslvxGo1pVsfGu/82mLl8gjhdkhkutije411A78zfiUZeYHLfuO75b/Dmp5HK//3VdHO
 RLcTNjQHks0UMWmmeTKRieSzRjsbEIbpl0+XtvliSNc91rQ5D/FRVub5CWUBUtkrJpRBCjr
 eYsWZLOHlpaCEoXQgv96Y0CIne/YvMtyS587Ls1QpmnAATaKL6s6PRRWCT4h59F6b99bw/S
 eqmL4wCMOsMYo8zuJXeMRpMYEPZ0mwqGctQ3CXIzwuD8rx3Stn1J3FAk0xxrLmCyTz2hF8a
 0u0Kp3fgcA9IvgeK+1gZ9UfE4hSYhwESskJARzF7+gXZruqBu2DdhZU0kXYe3e1HSFKsHlP
 FpqeQcsGiSuz4RwUWdmdgktbCpYPl6pCbVWaZ7fwv40CBMb9dhuHBhVVrQFTV++9dyaZnM7
 uuy9kpiyAMKfi5V0j2bSnzXiCChAv6Ig2oPvRjKmKAhoAbp5cxwA3RZg9+E44u92bvifYtI
 ezhBMkaqJdX2pz7Ry10Da2b1QdKu7FZtqjL4Z6142/xgRFFfK/xA6yUDcwTSTkt8yDlR/LK
 H5so2g3LxfJ8YGqBt2ze2oTKL+dyGvVwztrtUOdgpsMSHuwstrJ2a6hXBeX2MGoUiSQloni
 9uTkHfxZXtOOzB5oE4irGznIIjyDqBBqERasLjfUlaG
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

> v2 is out. I do not have a txgbe NIC, so it is compile-tested only.
> Would you be able to test it on a txgbe NIC?
>=20
> With the port started: create and delete one FDIR rule ten times, then =
check that PBRXSIZE(0) (0x19020) does not keep shrinking and that
> FDIRCTL (0x19500) is 0 after delete.
> flow validate must not change either register. A rule with an =
out-of-range queue must fail and leave them unchanged. flow flush must =
restore
> PBRXSIZE(0). SP and AML if you have both.
>=20

Hi Tengfei,

Thanks for the series, and for taking the time to fix these in the txgbe =
driver. =20

I have tested the v2 series on both SP and AML hardware, and it behaves =
as you described

No further comments from my side. Thanks again.

Acked-by: Zaiyu Wang <zaiyuwang@trustnetic.com>

