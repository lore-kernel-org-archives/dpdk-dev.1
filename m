Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79E1C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 02:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E408402E0;
	Wed,  1 Jul 2026 04:08:30 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 85ABF40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 04:08:27 +0200 (CEST)
X-QQ-mid: tivesync4t1782871702tac65ab88
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [36.24.190.76])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 14127012211826772614
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260617105959.10764-1-zaiyuwang@trustnetic.om>	<20260630111608.22196-1-zaiyuwang@trustnetic.com>
 <20260630071555.0b0287b6@phoenix.local>
In-Reply-To: <20260630071555.0b0287b6@phoenix.local>
Subject: RE: [PATCH v4 0/4] Wangxun fixes and new features
Date: Wed, 1 Jul 2026 10:08:21 +0800
Message-ID: <005601dd08fe$7defb600$79cf2200$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQINDEWtZfIg/XY4yPx5+dI8/7RKoQJbwG8eAqFlo8C1z/oDQA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M//muKyjQOU4/nA/ZXVjCP3ccBUmdKOXZZF/o2fDkK8sN789dUNCbA0e
 m5OITD0pxHwTe/dbrMLu+odAJ/PmBQsc56iFI+xL+LZkei/zJXy8EYEk09mPFWS4V0DrKlx
 thN+c6NvYoFDX0gY4aoRxvnlC5uC1k0TRw+cjNcfzXCKSj8JsiU+g1vsmozHx6qVovSNRoZ
 fNhtINLog7uujYB3k9uCwX3bi5hpsIz2tKSIscMi1dHAKf7qQJr1J0AnpUgN4rhoj1Ojtn4
 XjJbH04VrkIqEOS6PWshMYR2IbgJ/rk73tPv/TgD7CXGI4NDRN4nRPq9QdzHrqIxAnG6PI9
 DBZc4FCD55yn6kOGGgQQ317b+hbSXvAebiviGeMM8NrHhGuOYEAzisF6alRWOujha6VfQYl
 UZnS66N6RYr0fNQVxPzx8+S5KXJY3PxCyMXcLKcyerrdgFWVjpJr+YJhW7y7pba/l3FIdDc
 SbGKPvCFnSuG1VGRrQMPOsP9hVhfWVdpyCQ4WFzk4FXciT1TgyF7A0kwHmsidfmZEbXLEiV
 3eHO3PFIj3/CNTy3Aw9Wxwh2TCSHH2c2+7ATMT4r6R6s/5OcHE+Dyx3PLGBITWl3P4bwOpy
 PJnaAYaaY0DKDNTjo/ylG/C+3NmnsqV/N0vAktyTTtQSLBQn5R6VnhROmcPYgJxn1Pds07Z
 iU/3Z7GC+84UJtLOlY5UtmeS2PbxtRJN/amC6JhgYFi5MR+2blHbPcZ0D0Ff2fGO3V3TYCI
 FBxceq/3+mgUjUtRCEyMe9Vg2QDuLsy2nc9rBf733fKm7+YaftSODOzI7Z2Z6S8trwQEdzz
 6nYJ59cJlJ+1ZDXsOJE0eiXfGAIQ/ZPEJG1qUMVPV5mcl/NKqmp71zqWh5YnGxO+NDyf3J8
 2rTvDS2DQ9EsNRQm197MZ6YgaZ64V7iY0JZ8s7nEU9/q1vg+EqHdcRBU9ZsNkgReO9hVxF0
 5XsO9OjkoCAkOmpMRXdEqNNeq+usJRiRAIPswT7U9Qne25cbYU9uSgfpgU7eiEnoQs3PB/+
 xbvejy/R6Offz0UJGi
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

> On Tue, 30 Jun 2026 19:16:00 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This patchset introduces three new features and critical fixes for our
> > recent release cycle.
> >
> > Patches 1-2 add support for UDP Segmentation Offload (USO) to improve
> > large-packet transmission performance for UDP workloads.
> >
> > Patch 3 enables VFs to sense PF ifconfig down/up events, allowing
> > better fault tolerance and fast recovery in virtualized environments.
> >
> > Patch 4 adds the missing VF support for the Amber-Lite 40G NICs, which
> > was previously omitted in the initial integration.
> 
> Applied to net-next. Had to resolve a code merge conflict from earlier
> changes in net-next and also release note conflicts.
> 
Thanks.

