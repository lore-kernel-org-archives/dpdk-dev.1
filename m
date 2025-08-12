Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E67CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 10:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42A564064F;
	Tue, 12 Aug 2025 12:39:22 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 7EFC94014F;
 Tue, 12 Aug 2025 12:39:20 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 282B74013F;
 Tue, 12 Aug 2025 12:39:19 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 67BF57A0142;
 Tue, 12 Aug 2025 06:39:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 06:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1754995158; x=1755081558; bh=Ii
 1oCKVIIevoFrkd8UuZ+1b41z9/G0ilLphGQ4YaPgs=; b=GE+IIoYtU/DIIaH2ZI
 3QyPeoCvLFuD13HGzAYUzfJRfktq8dOMuWCe5o2xZgPXICh2KPGqnCi2Uc3y07EW
 i69CImmJJnQ7d175JYhpO+trb2q/G+fMsaG+ic7QCohJlQASo0ZwofvmEYjHuZVI
 K/8L0Ra6JEE3epEi/GZrOLJl72JjA+8z0IB16tYKU+Ed7WrPTNeupOdY6DlXM+8a
 E2gECnn8W/Qw7PKWfD6s5WUcAdcAawK4vioH3OIhDRg23qX1aB1erSHJGyyRTaEi
 Xy6CrQzNTbMIw7k27CRuWkQnonWSrSdXlODfj+rmDKrTKG1mUBgce27YGvHdBwyH
 kW6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1754995158; x=1755081558; bh=Ii1oCKVIIevoFrkd8UuZ+1b41z9/
 G0ilLphGQ4YaPgs=; b=ma2fubWSk031PnpY8etBUMnk7Pq51pZP1Vlqd2SUyQ+L
 sWfl7NslbT/JXnCdJXS1nhV1fpMnFfWf2SlRz455kkeShiddFIqtDjt5sjwfUk+/
 HG97uaWLeh7O6P2ZB183gLiI7aRiOu0rhk1IsjDlmV8fPdYTcz5aiAGwP5X0bByo
 7uLOsP8qMwtTTXWEEb3HbQu9KWAQnyduvjwHOGobpCldSYQKYEY4KCAx9z0Dtvk0
 jR8fGdIDLGqBM/hO2RvGM54RjnT8/CgrCS41C+QveCeFhquiOsF5Y3GY/Yl8m0Xg
 oL8Qrg5yZvfLYyRb/nQ3KFirXahVACMDVQE0wpeurQ==
X-ME-Sender: <xms:1RmbaH8pnXpwLnAoZ8tuFsH8IjUddUH2zv1bBQiTqmdRyDK8fBryRw>
 <xme:1RmbaI_ORdrPexe2-kukoIYQVqz52rTAA9bsh1PM1so_mgyGocTbSmrIpnEgA6TVM
 oW4SSrW7E_-pRbc3Q>
X-ME-Received: <xmr:1RmbaGsMte2Sd9sXos0MSDx2umysvEmTb0fW5fIRFotXlS1ZFK0uyHAXyiL2DuL3JNPmRESiS-Cxgq9aoGMYcllVxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehudduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgggfgtsehtufertddttd
 ejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepueduudehgfdvfeeivdejhfefve
 egkeefledvkeeuteeikeegffdvtdetueefjeefnecuffhomhgrihhnpehlihhnuhigfhho
 uhhnuggrthhiohhnrdhorhhgpdhfrhgrmhgrphgrugdrohhrghdpughpughkrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhm
 rghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtoheprghnnhhouhhntggvseguphgukhdrohhrghdprhgtphht
 thhopehtvggthhgsohgrrhguseguphgukhdrohhrgh
X-ME-Proxy: <xmx:1RmbaLphK1AmuFq-xvKkJ3UDiDd5HORK1CjEJhngSwD7Ste8kP1WZA>
 <xmx:1RmbaDkBmKcG_KSBxfn85jtCMM5MCtQrt0ks_pDLwwiIbf-GwkiuJA>
 <xmx:1RmbaPw4JGUkMoOCKog_HY-Fq1S506r1f89MlRAoOLxPPENrcz67lQ>
 <xmx:1RmbaLmWhkmex2vYA_9eIxFAiFHrVlrwgR22bxBVVO_An806vpX0qQ>
 <xmx:1hmbaJwdg1OjNvTwQnjVDZfPaDSWIPHQQ983Rhm8sYQKBWsoIcm2p7ab>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 06:39:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Cc: techboard@dpdk.org
Subject: DPDK techboard meetings
Date: Tue, 12 Aug 2025 12:39:16 +0200
Message-ID: <39887866.10thIPus4b@thomas>
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

The DPDK Technical Board has a meeting every two Wednesday at 3 pm UTC.
Everybody is welcome to join with the link below:

https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb

The meetings in August are cancelled,
so the next meeting will happen on September 3.


What is the goal?

Some technical decisions of the project are discussed during the techboard meeting.
If a choice is needed, a vote can be done.

It is also the place to discuss how the project is maintained,
or give technical orientations to the Governing Board.

As we are in the second semester of the year,
we will have to help with the budget decisions,
like how much CI or AI workload we need for the next year.


How it works?

We establish an agenda few days in advance by submitting topic requests
to the email techboard@dpdk.org.
The topics are listed by the chair in the pad below:
	https://annuel.framapad.org/p/r.0c3cc4d1e011214183872a98f6b5c7db

The chair role is rotating between the techboard members:
	https://core.dpdk.org/techboard/#members

The previous meetings are summarized in emails linked below:
	https://core.dpdk.org/techboard/minutes/


Do not hesitate to participate or just say hello!


