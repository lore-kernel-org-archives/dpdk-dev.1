Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB20CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:56:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C92340659;
	Tue, 12 May 2026 09:55:52 +0200 (CEST)
Received: from outbound.qs.icloud.com (qs-2004e-snip4-11.eps.apple.com
 [57.103.84.53]) by mails.dpdk.org (Postfix) with ESMTP id 2C76540041
 for <dev@dpdk.org>; Fri,  8 May 2026 00:25:40 +0200 (CEST)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 BCF0F180014F; Thu, 07 May 2026 22:25:37 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ5LHVsDRQBEDFYCWQVLVxQEGV4MWQFTG0wWXQhbK1sTVRdGCRkIXR0ZHldQVgZTHlMZWBhZBVcceRFQAVgeVl5aF15NRQgPQhkQVgFYVl0FTRpcGFkPHAFKVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0wOSXVYAV8BRhRNBFkCRgYzfEkeVAQodl0BSQBbAFMKNQ9NB1t3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1778192739; x=1780784739; bh=xTbE3oKIRJVyp5QnxMkTsUfJSVOZ8g86eRj/5hX4sG8=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=L4ZDpsHNlehjD2KNYPnGGzB5Ra7Xb8MmdLz/iytINwshaNTqQPI+rrhLh7m5XtyLKTyu9tfYpes4JoivA854gWVit6/XUXU2Ts3OjcCjWuzQYK2E1mPHcxDAscciN0qk9cfT7dqgvaAFqMSltNgoubyQSyKy2/P7NGvFh+hV5r60MIH1f9OPcbGx3468Gw/nj1irqANdMzUIwrM9Cz2UwiFBNL1lq+oOTv0Sg/GooNzEFKU76DOX4Zrxx7mJqyXENQse06ojpnyGn5XRboYlF/6AzcYvRFrNmYM1LB9uRn6lLiqXsWYaK3fA61J+vkYPHyml2Zg32l29dRc4WtV8nw==
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 DAF3218003D3; Thu, 07 May 2026 22:25:36 +0000 (UTC)
From: Alex Michael <amanjakunnel@icloud.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 6/6] cmdline: add null checks for invalid input
Message-Id: <71F56436-5745-4CE1-93CD-8136788E6546@icloud.com>
Date: Thu, 7 May 2026 18:25:25 -0400
Cc: dev@dpdk.org
To: bruce.richardson@intel.com
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIyNyBTYWx0ZWRfX/gFXBQketN5g
 S3CxJapZyQ1V/ebY9M1t0cBoVtZu01r0Tqt9XFOPzffUTGscDhRo/urLtpaUIfipp73Wkj0Yqnn
 elCb/iSjk0F2ANKa/dDRnztZez487j4FtApNSzEkFmWQ6KNF4Am5gVNjsGqvKMtLZn7KjMD5cF8
 imR/5vMJiCix2nOvqvYpoL5qR+GbW0489CSnLSp+0nmw4G9+bjOcddGdCjQi/9fU64Q3HX+XJWX
 eFKADlYzjfTAc4JsKSpL8jatgH8v+g+GqIILwhtvvHgtcHtMomfYSoKYWOQXHEvqsOQncaBegCA
 UDTME7xhLmhWnUBXTMdQu3Za8Y625DvQHZjlwvf4PW7Co8vxLkxGOPhJzNu6Io=
X-Authority-Info-Out: v=2.4 cv=dqzWylg4 c=1 sm=1 tr=0 ts=69fd1161
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=JBPM2hY0xfcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_PUJL-dSVCCn9LS970gA:9 a=QEXdDO2ut3YA:10 a=pTjhX_1JIgTf4pzf8nHa:22
 a=-cWf4ZYUzybU3ERL10ov:22
X-Proofpoint-ORIG-GUID: MfI9HFd6VO347LCMJPe-bWO-tDpwfhXO
X-Proofpoint-GUID: MfI9HFd6VO347LCMJPe-bWO-tDpwfhXO
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

pmd_buffer_scatter test suite failed on Ubuntu 24.04 LTS with an Intel =
XL710 40GbE NIC. Conversely it didn=E2=80=99t fail on Ubuntu 22.04 with =
an Intel E810 NIC, so the issue lies either with the OS (mbuf size or =
mempool configuration mismatch / buffer handling logic), the NIC =
(driver-level bug), the interaction between them or the test suite =
itself (as it should be unrelated to NULL conditionals).=
