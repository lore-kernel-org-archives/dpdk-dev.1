Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A5DC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B714F402BB;
	Wed, 12 Feb 2025 02:50:16 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id C635740269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:50:14 +0100 (CET)
X-QQ-mid: bizesmtp86t1739325004tdnpj1qx
X-QQ-Originating-IP: 002qsvGGXJcohblTzUzG9L+eiNjAJuuMxR6RTVWSP8M=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Feb 2025 09:50:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16923138145981230284
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>	<1739263818-59770-9-git-send-email-caowenbo@mucse.com>
 <20250211080202.621a091f@hermes.local>
In-Reply-To: <20250211080202.621a091f@hermes.local>
Subject: RE: [PATCH v9 08/28] net/rnp: add queue setup and release operations
Date: Wed, 12 Feb 2025 09:50:03 +0800
Message-ID: <E6209857AB9C9268+001301db7cf0$7005b8a0$501129e0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLqICmjQftEF0oQ/zI69QXbQqbszQJof9ghAXG/3LCxBsqYoA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OPbPBgDYDz6myxhbjwiPabNwbBes3tss0V7VG2EP5XYWZNdnYrNq22vH
 a9RJ+oIoOX/ia4qC3XiULaNg0sZSijSdTlG+nf5/DD3TIU8WqvGDf8XDBCvCcjqpZll3n+i
 X7pzW8rhQ2eH2Dkg4iZxqhrx5RAl1nEtiPMN3Mmzf5z3jRBlkqI/TFaycdDkeAHsHR4ePdX
 BtKaWaaGk2rpoB1QUwYcAO2gVjfF0t+btBqQFJMx1V4zkNf6Jul0FdUaV8+E8QDdtV6qV1T
 JXzm+QjUIsYAwEJK8Yu8VBZmgSMmwLou7Q8b3gezlM2muXMMG5lqId8xGqYg5fbf8BRKPuz
 SIaIc0u/Udf4sGoazWOo16qtQYXbnd9mCRr6Zc+mEcTlmijzO/EQmrSEKCIUNauOwzFT3w9
 WuLQ+iUaibM+JWJnry9Ir05hd0wmPjm2E3wz9oFXU17aFG/Sd4nY/IwMfz5GuaMXJOQF8qw
 lvRBtOxgktfQ+C3EWmfs66FdwdYShkTYUmApP+xlRNZG/hqFA8FP7l8AayeEQrgRyVWOwfb
 p96MhQlZMGxX+csOXgco5Msc4ukEYiUTRfTzeMePDu5m8/SWvGlb9amUNKhd6b3kVVfpoU1
 yefX9BGjF5k5tnORG5ziMGPmQ5XQKGuw3o3sZvhqBrImnkQwLY87oZwZ7o2UavAsuOnA2Ac
 QEBTHgJICJpLR3kE7WTy2srZkz+TNMoqi/4Y6doTBtiQE5asj9PuLDMwBwbGf7X1UXRXpzt
 TkSob4hfDi+myKrhDgBrBOJQvq5Lsmt+YuLi63BKPFmNT3en3SXDxVPWyldEAPizauCxddq
 RwjZYRzmVzXWAHKWBaIJMSF3OkwYVKFqS8J9JsSLMpQKwIup/pEYQUytr0m3uVTGWjBzI50
 vMjVctk8Y4C3QRrkbT+vIu6J0tCXqnti2oixjsCjaEd5El//eR2AJA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Hi Stephe,

The spinlock of rxq_reset_lock, and txq_reset than I need it to make =
sure
one time just one user can call
queue_stop operate a queue reset, hardware only support reset queue head =
to
zero only one user operate.
When queue_stop 0 and queue_stop 1 operate at  the same time, the =
hardware
queue reset will be fault.
Even port0 and port1 of  one pf, operate queue reset will be also fault.
For rx_burst and tx_burst that I don't used the spinlock

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C212=C8=D5 0:02
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v9 08/28] net/rnp: add queue setup and release
operations
>=20
> On Tue, 11 Feb 2025 16:49:58 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > diff --git a/drivers/net/rnp/base/rnp_hw.h
> > b/drivers/net/rnp/base/rnp_hw.h index da2c1d3b0e..ea4e1b8d83 100644
> > --- a/drivers/net/rnp/base/rnp_hw.h
> > +++ b/drivers/net/rnp/base/rnp_hw.h
> > @@ -120,6 +120,9 @@ struct rnp_hw {
> >  	bool lane_is_sgmii[RNP_MAX_PORT_OF_PF];
> >  	struct rnp_mbx_info mbx;
> >  	struct rnp_fw_info fw_info;
> > +
> > +	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
> > +	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
> >  };
> >
>=20
> In DPDK control operations do not need to be thread safe.
> Many other drivers do not allow start/stop in one thread while tx/rx =
are
> happening etc.
> This is because rx/tx should not have overhead of any locks.
> The cost of one spinlock at 10G will drop performance a lot


