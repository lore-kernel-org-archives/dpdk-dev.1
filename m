Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A0CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3FAA402A0;
	Fri, 10 Oct 2025 09:49:51 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id E2D7540285
 for <dev@dpdk.org>; Fri, 10 Oct 2025 09:49:49 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0CA971D0011A;
 Fri, 10 Oct 2025 03:49:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 03:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1760082588; x=1760168988; bh=WJJq6EmyY/
 487pi3FvAg+EIu5ha9lPPbrRBSBxTItYY=; b=Tqd/u1Qivp+mEcJadSE4AnVhm6
 wmGkPTV6xciGV/P6NPHjc1b9mxduZTxAUQjop9JgHQRk70cKVMeA7W4Eek+QhaT7
 jR4s1knFuq8w4vXyfOhE8/Ky2+Q36GPuuqT3oi6S49KtYk1vT4+/5WWoRwBQJaZy
 9aAg9q2tYYUvKV1d37LjJTuALFUq1EsQJsp32NTwKIr7/LcQ969SjAifJhVyo2SN
 kaYcv3hDuZPJhMN4akKdyqeJPk7ES/VR3wfO9LBI9rsDjDvXicLqUInihraW+6s1
 kpZX9bph6o5zVlXzkU4mfb9boNrBTm478obBGI/JISXtslKjNundsz/0EMJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1760082588; x=1760168988; bh=WJJq6EmyY/487pi3FvAg+EIu5ha9lPPbrRB
 SBxTItYY=; b=nhua+OtKs9WcQsWCEcS0Yu1+pQFXwXA1a+XD2LbqPajnBbF6S08
 ARKq8drTWP+xC4ty4cl9eEiPsiTclAJDzkyLVyCUrZnx+ix38xzoqwpE29AD2bw1
 YHNTXEDVtQviggwRm6OTB/1u2dy6qDBk9jFq85PAlxcJgxCFox5tdwH2vRTH0OIP
 90cENdeSIuwyCvotwRCfYwfVnMJO6DHU5H56mdb1nty9VVBo6hj+th7vwFJGcRSZ
 CTa225WJj6RLKuXynNfu9lJ2/TO4xEu+cn6SHtGG6iahOVJpE1Kat4DWrYYpiTNX
 nD4pjlGvPN/rmFVCGZ29RPrMb0WXhkD7WZg==
X-ME-Sender: <xms:nLroaF6Ab02_S-nZdLXbUevPsDuSddzc5QiRglIUqZ8qd8d-7oI9wA>
 <xme:nLroaIytE3NAvOdfhqBRYWzF9xgVimLIPPJfcWkTNvn51V87j7HHebfb9K_n78NWl
 bJ1q9IA7yONwseNdIyaXNuEOLNqbt6p47XnuoXZjf9iqDWfpiAg0V8>
X-ME-Received: <xmr:nLroaHh5DRtYoNyZxBjjhRMhyjC1-G77deRz7ZJAN0e8llqsgYCcGMfVcOl0I0yDCJccAiuqs1r-e2I60CQpnRaMKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekhedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkggfgtgesthhqredttddtje
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejgeethffhtefguefgvdfhgfehhe
 egteeifeeufeeukefgkefgudduteegkeetjeenucffohhmrghinheplhhinhhugihfohhu
 nhgurghtihhonhdrohhrghdpughpughkrdhorhhgpdhgihhthhhusgdrtghomhdptghonh
 htvgigthejrdgtohhmpdgtuhhrshhorhdrtghomhenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:nLroaK-cHlExpm_Ogj2LCtw4wp5m-1cJ9EWJQWZLRaztWWKcpa2I9Q>
 <xmx:nLroaMtbRLrIrnJWxR69PVds7n2UyEweuYGCNQzEd51-EMhVcsaTYA>
 <xmx:nLroaJb4LMt2lHHD9G9UHRXWpv4AAGwShh-QNqWPT_B4yj_QaRe_Fw>
 <xmx:nLroaEqR6cgbjdj5W-ivch1-PtCTxx7WpaD1fNWhKxSzgpFQzxu4wg>
 <xmx:nLroaOoodikAvsEXLLOzZHkKSRbmL7_l7UL7ojEP6zX5MVujmi4DB1Lb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Fri, 10 Oct 2025 03:49:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Minutes of DPDK Technical Board Meeting, 2025-09-17
Date: Fri, 10 Oct 2025 09:49:46 +0200
Message-ID: <2986146.NG923GbCHz@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Members Attending: 9/11
	- Aaron Conole
	- Bruce Richardson
	- Hemant Agrawal
	- Jerin Jacob
	- Kevin Traynor
	- Maxime Coquelin
	- Morten Br=C3=B8rup
	- Stephen Hemminger
	- Thomas Monjalon (Chair)

NOTE: The Technical Board meetings take place every second Wednesday at 3 p=
m UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwo=
rd=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on October 1.


1/ AI-assisted code contribution guidelines

=46or now, no specific guideline about AI-assisted contributions.
The board does not recommend any specific tag about AI in git commits.


2/ compilation option to enable optional parts of drivers

The board has rejected the idea of a common compilation option
to enable optional parts of all drivers.

If a datapath may be accelerated by removing some features,
the recommendation is to have separate Rx/Tx functions
which can be selected at initialization.


3/ default Tx configuration in examples

It is not clear what should be the recommended default
regarding RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE and RTE_ETH_TX_OFFLOAD_MULTI_SE=
GS.

It is also not clear how all drivers behave regarding the fast free offload.

The board asks for clarification about drivers behaviour
when RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE is enabled.


4/ LTS releases

The maintainer for the branch 23.11 resigned.
We have 2 active maintainers for maintaining 3 LTS branches.
As a consequence, we are looking for a new maintainer.


5/ AI-assisted code review

The board discussed some code review products.

Aaron is enabling test with CodeRabbit and Sourcery in GitHub:
	https://github.com/ovsrobot/dpdk/pulls

Jerin recommends looking at Context7 as knowledge base:
	https://context7.com/dpdk/dpdk

The board agreed to test the bugbot of Cursor:
	https://cursor.com/docs/bugbot


