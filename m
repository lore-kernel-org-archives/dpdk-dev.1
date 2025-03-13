Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5576C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 14:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA98740FDE;
	Thu, 13 Mar 2025 15:51:41 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 8024E4025F
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:51:40 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 17EE41382D0A;
 Thu, 13 Mar 2025 10:51:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 10:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1741877500; x=1741963900; bh=1qN9ehE6PU
 bvia3/4mzbTATHPtwm25F8LMTBkcd/AEg=; b=oAQG7tW8XH14ECvQLHdtA2b3k2
 IAy9wFRdcDi5uJ42z6d0ne5l0/PSmEZe1tc0Fd2L5kzqFVeuqZC/WZCorAlnbBkS
 dHA2wBAtquy5R5cw8iFqMIGFpP723XvH2gnCqdHNIiQucoyWqKZkIrajdF+QEx/8
 vcEfb+Fql0IkTkM4LLJA2ygVHl3RYvltWRs7i37L3oXd95DEBeii5PHhNTkfnXlT
 voQNyBodxz5+2TqBtvR72rhMqZfkaJ93o9BejKfxRWOqzPcehQ4QMwHZJlswRrsF
 /XWJXcossZTSZc3xwn7XF8GfiNu0yAfkv35qSo7TyAm8p6GQYqcS9GHml58w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1741877500; x=1741963900; bh=1qN9ehE6PUbvia3/4mzbTATHPtwm25F8LMT
 Bkcd/AEg=; b=nPYe3MHzQPyn3vRxcWcqr5jVolmsxYHt08mCv/tRS/fLCmUBRFn
 68SVq2eMfF0HNl4m9W4xHODH3midBUAvzVYoH8T499TuLJRKWCmDDMNWbosDDlZq
 CSKTB28JTQMrrhfWzaCtBi3MAU6KX6LlPcdYeeB3vGFqkoIg+yUsFbbH+Ujh1SSk
 SICWCT7Kf0ATfSCTbkCEUyVHa8Rzph6s/sYzKAZcgsNBP/g3y5OnvG+UDkIWYNmh
 hAV1YozksZdVr3SSDciw0cgfCs+yyMqRqGruK0n1gqFyorjM8uf2mti8ZdaiDR9D
 vJZi1TL1lo+ZVmRWjhmZonuExH7crQFiAHw==
X-ME-Sender: <xms:-_DSZ7xMQsq9Hziw-MrdCyBH7GaENhsxwHU1R8MKrfVE-ZqDyqHTtQ>
 <xme:-_DSZzSwcbz9BKyk2WslRRzi5DCOFtHl7y-2PPW0wj_OR8ptIHTZ23vYNo7_Cdjr2
 TvrACbB6dKQKXXzbQ>
X-ME-Received: <xmr:-_DSZ1UWB-B2E_9mRANPWohdYnPk9Q7OhCbjHDEBSLK2pFRgLtTwmCR98Stqf3F7owPUjhoVH7WJUBv2YdJhAfy2wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 fufffkggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhho
 nhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpe
 fhteeulefhheevudetvdeuleehieevudetheehveevtdfguefffffgfefftdfgleenucff
 ohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghdpughpughkrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhm
 rghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:-_DSZ1hMVFLjea1ObQfD5wMEVeZ3vzolmSWpQEtrkJDVqmhuEbQdMg>
 <xmx:-_DSZ9BV37co49rWqYOUqwxum8HyYjKkiRIs1_5zsBNG-kTvjEfJIw>
 <xmx:-_DSZ-IF1-3_OhPq_vOi0bDW_TgG81skIhRdIV6IfXFpOg-n5-vaNw>
 <xmx:-_DSZ8AezE7oRRRuhdJOsY_DKGf4cWB5UmupFivjqJnInk-O5lwa4g>
 <xmx:_PDSZ66KV8QqBsJi_aWTtpv8JIrFrOKKUR7mli6yE8spsBT96Fpmtqez>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 13 Mar 2025 10:51:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Minutes of DPDK Technical Board Meeting, 2025-03-05
Date: Thu, 13 Mar 2025 15:51:38 +0100
Message-ID: <5321615.eFTFzoEnKi@thomas>
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

Members Attending: 10/11
        - Aaron Conole
        - Bruce Richardson
        - Hemant Agrawal
        - Honnappa Nagarahalli
        - Jerin Jacob
        - Kevin Traynor
        - Konstantin Ananyev
        - Maxime Coquelin
        - Morten Br=C3=B8rup
        - Thomas Monjalon (Chair)

NOTE: The Technical Board meetings take place every second Wednesday at 3 p=
m UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwo=
rd=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes

1/ DPDK Summit in Prague

The CFP has been extended by a week.
A good amount of proposals were submitted.

The techboard meeting will be in Prague at 4pm, May 7.
A joint meeting both boardswill happen at 7pm the same day.

2/ Board Initiatives

The 3 initiatives about cloud, security and AI need more efforts.
We may try to work on them with some students mentored by their professors.
The next step is to find some universities to work with.

3/ Governing Board

The techboard can propose topics to be discussed for the next govboard meet=
ings.

4/ Code Challenge

The topics are chosen but the format is not decided yet.
It is proposed to progress on the format and organization
with the help of a spreadsheet, including votes and decisions.

We should require at least one mentor per topic.

5/ Contribution Policy

Aaron proposed a policy to improve participation on the mailing-list,
reduce the noise, and help the CI workload.

The RFC is sent:
https://patches.dpdk.org/project/dpdk/patch/20250305013351.2209789-1-aconol=
e@redhat.com/

6/ Grout Testing

Patrick (UNH) will check with Robin what is needed to start testing Grout i=
n the lab.
It is suggested that a weekly testing may be reasonnable.
We'll decide how much to invest (effort and machine time) in it during the =
next meeting.


