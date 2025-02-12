Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE9C021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 03:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9C8402BB;
	Wed, 12 Feb 2025 04:22:34 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id E083B40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 04:22:31 +0100 (CET)
X-QQ-mid: bizesmtp85t1739330511tz16g1os
X-QQ-Originating-IP: 0mwHGIixmuVR95H2/9Je0Owl7AqN46sWB6H2mhxb8KM=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Feb 2025 11:21:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 623971779984092225
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>	<1739263818-59770-13-git-send-email-caowenbo@mucse.com>
 <20250211073503.78f084ff@hermes.local>
In-Reply-To: <20250211073503.78f084ff@hermes.local>
Subject: RE: [PATCH v9 12/28] net/rnp: add support link update operations
Date: Wed, 12 Feb 2025 11:21:49 +0800
Message-ID: <89E4C0CDD2F99463+001a01db7cfd$4210f7e0$c632e7a0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLqICmjQftEF0oQ/zI69QXbQqbszQIbDFRwAY6R32ixCGWdEA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MSstRF5C1p/jJyGakUyy1WSdWcXAo7E93x0DFy33jsg7tKl+OwsFKuWm
 ejeTMHnc7KRAcSC9vBe2OSPalon55a1gUjHXug0Xo/Z+Ads46qDvEX621OjvXYGrSbutQ4J
 Uzr2MQZrLWCu7hdJDA5K3aB4cDjFkIlimEPyaF/vwJyDEoUeKvviF2WfewU61YITz5ST8iK
 ioTRsW1XC98EAq3wcIjFLAH0MRxJfdHUdlk6FR9wiC8EmjXpwVwAVwQRbd4o5f9SDcPJerY
 qGBpux++UBNS89yrc/OUsFrwTJsBPeVjcloMxaPZyDHwf24I8QUXmlvXtKjhVt+XoZiQ4cn
 Rh6PG44XVx8iObUCHhJrJlwsVkJpDuPQ5euoH7vctQ0s9ZyrbfYdvs3TGAtNuQstrvdeHuL
 ckN0typzyrDtBAFvWXVJRvZ13GpDCIAFj6rcIjWOzNXl51GkbSll9myyJeCcd6myeebeurH
 AIEmxn5qSWtOCjMHvEtOQ9ghwRYv3zqWw15EAQkBoRpsZRFcyQTB59AAt9FpNRt30qfPs4v
 AP1qtmJ4X+LlXTdzwCmtTReaMGtqAO0uWefYgy8T1B9/uo44PUoiMzfwcErHsK7q5bSnhL6
 KnHaA2lpToeBoCZno4rPIJ1DcaZNcLO+qJdNSSNiCm22VFNTEQJjYJNYVb/tz0qwTppY34L
 VuFWyui3zqFDQ1yc8V19utRNV/FtWMERxjXwo/EV/JXdD9VAuX4m95LkUXzlbGshEyIcxjp
 PTkm4P6UQxQ3Vqi3/mErnCQXCOvvu6qHgBTnYu2I/G3XJsQxZ+T4/vQSLJNRy5aLdnJsXAg
 YB2yY4HL5rNLit5Khtvo2LWpV32ZoV75nbrc1CMGor3NxFGmBSR6LOAFGivlXL2y+qZVUoh
 5NRZr+z6JUKdOtZCXk/ChEM4WZ9LHUsGn7MsgQvt4a/twgTUMJjzFSYdW8/IwMUSSAgTRKr
 U1oGBk2hNiPAI1M666nVbOwtBlQKFgjGDn6kQVDMtL/Oz/den5lmnN65JVWkCEIG2OYhqsS
 +A3G/DWInD+TELXkGv
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

Hi Stephen,
For memcpy what ever base code or other code all used memcpy not =
rte_memcpy
?
Even the memory is malloc from rte_malloc/zmalloc ?

Regards Wenbo.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C211=C8=D5 23:35
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v9 12/28] net/rnp: add support link update =
operations
>=20
> On Tue, 11 Feb 2025 16:50:02 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > static int
> > +rnp_mbx_fw_reply_handler(struct rnp_eth_adapter *adapter,
> > +			 struct rnp_mbx_fw_cmd_reply *reply) {
> > +	struct rnp_mbx_req_cookie *cookie;
> > +
> > +	RTE_SET_USED(adapter);
> > +	/* dbg_here; */
> > +	cookie =3D reply->cookie;
> > +	if (!cookie || cookie->magic !=3D RNP_COOKIE_MAGIC) {
> > +		RNP_PMD_ERR("[%s] invalid cookie:%p opcode: "
> > +				"0x%x v0:0x%x",
> > +				__func__,
> > +				cookie,
> > +				reply->opcode,
> > +				*((int *)reply));
>=20
> Don't break messages across lines in source. It makes it harder to =
search.
> You don't need __func__, it is already being added by the macro.
>=20
> > +		return -EIO;
> > +	}
> > +	if (cookie->priv_len > 0)
> > +		rte_memcpy(cookie->priv, reply->data, cookie->priv_len);
>=20
> Use memcpy instead of rte_memcpy in all new code.
>=20
> > +
> > +	cookie->done =3D 1;
> > +	if (reply->flags & RNP_FLAGS_ERR)
> > +		cookie->errcode =3D reply->error_code;
> > +	else
> > +		cookie->errcode =3D 0;
> > +
> > +	return 0;
> > +}


