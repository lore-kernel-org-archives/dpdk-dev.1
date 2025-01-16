Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84136C02183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jan 2025 16:38:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC9C40A75;
	Thu, 16 Jan 2025 17:38:10 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 47EFD402F1;
 Thu, 16 Jan 2025 17:38:10 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 1A8314026C
 for <announce@dpdk.org>; Thu, 16 Jan 2025 17:38:09 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4CFCA25401BA;
 Thu, 16 Jan 2025 11:38:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 11:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1737045488; x=1737131888; bh=8D8plyrJ46
 DArRPoxLzaZ/0a/egYARsTGLlSUd3OxpI=; b=HmZLTW1v2k5tjgByPyuf2RqroT
 yhTRlI2zUAXVKDK5/hiUN5zNnmaAp9L24z6u19jUZo1Mz4+GcYc8dC6c0R2s67Ps
 QvC7H/FufXBPQS8hJpraRd/u1x90kyUhVRpD8BLUTAIf4XnTJSTf+/GgKoeQtdFa
 rPLGB2tLkPkDE4DcJuY3tgbihrE//X1VxT0MfEo+pZHd8cL3Vl0vfjgV92rhTt1+
 DoTXF/gAtKv7HS2Ho4osAx9p61gUf+Re7KgNKmjgZaagx0uyFOTYX4JC5PqBp+CU
 3jRh/rx/k0BgfscT3tsDpwghS4btHqY5MoMGOTrG8EGd71ma+0NJCmxwvayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1737045488; x=1737131888; bh=8D8plyrJ46DArRPoxLzaZ/0a/egYARsTGLl
 SUd3OxpI=; b=LOK3RxX2K2HuBlIyqVgyYJSvfV+9FyGa+txD5MhoE5T0tXIo9dD
 Bd2tHbEx2o2bJc6jAtg3svDqlY4kEp04OisFN9zpu459pvEp0m39tQlwlSaz5m/4
 95HT1mDsJiCxu0mEMrQ8JCYY5kHZRb4OwR6AdnsNQXehPdsclbulvKJq3AzTaIqi
 gHp1mj3yvaWL3Ir5oG8j0IBtC5IYmE/qUe4BfYSY8HmgE9VFw6Rh3gUO5Ir6x1hH
 g2MSJReX2W9x9MdlOuQFgvzKqjuOW5uDiHcE0MlQ9Af0aE16xQ5dPlTQ+4G3FE0B
 GI3D1FG/4GAvXRQjJjM61ywzE8mu8kTtnrg==
X-ME-Sender: <xms:7zWJZ1zpWAh7fg7E2_GqSQVrzQxAeGX79gTfVP2FpNMIKoMnLQjhrA>
 <xme:7zWJZ1QgSqCqCLge7_j5X6SppdzkTHzxz269IMoo-iPuyR-Fn_093gEcLviYJjX-W
 P429aJ8vl3nFP8roA>
X-ME-Received: <xmr:7zWJZ_WTa3VBtCUgFkqfUX7pkAmemCBZ75vZui9e5zEEIkFHfEr0cM6ov72QTRWmh0oA2nL1RvXRWs9nWNCyjzTkVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
 fkggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcu
 oehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeelff
 ehvdeuudfgffeuvdetheethfegleekkeefteefhfdtkeekkedukeevgfeitdenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmh
 honhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:7zWJZ3iJe8bLUynPPu-njuKYXKazlS_keuM3EQzM9X3-2-TPp-EdMw>
 <xmx:7zWJZ3Ac_4bHQ7NF7mLltebbu-VcGliAtKqNCVw-q6nOkwZxZj0QDw>
 <xmx:7zWJZwJYUoa2Iv8IAIsgC6AcQajGVNiqcp5Y3mcXrjMhuhL-7N8YPw>
 <xmx:7zWJZ2DWlnywdeghTPR6--OmiI0uyFWSpa385i6LzixBUSZm98nuuw>
 <xmx:8DWJZ85L_dGCoEyZSWLewOUX7NIgDR-rEGW5bOXtoPoL744TKYXCX2hn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Thu, 16 Jan 2025 11:38:07 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: 2025 DPDK Summit in Prague
Date: Thu, 16 Jan 2025 17:38:06 +0100
Message-ID: <2582642.4XsnlVU6TS@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hello,

The first DPDK Summit of the year is confirmed:
	8 & 9 May 2025 in Prague

You can prepare your talk proposals now,
the website with full instructions will be ready next week.
It is planned to close the CFP period after the end of February,
so the program will be announced in mid-March.

The program committee will prefer selecting in-person speakers.
We hope a lot of people will be able to join us in Prague.
It will be a good opportunity for all the community to connect and discuss.
Everybody is welcome: developers, users, architects, students, etc.

See you in Czech Republic


