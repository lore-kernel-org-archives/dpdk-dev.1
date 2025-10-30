Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF17CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE4C24026F;
	Thu, 30 Oct 2025 18:53:39 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 56C4A40150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:53:38 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8914D7A00AB;
 Thu, 30 Oct 2025 13:53:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 13:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1761846817; x=1761933217; bh=8gbZVU9sgtS3voSzd+gbM
 JkOr4bx8p5iLF5gJ0dKylk=; b=XObzOOiCsxNzFa8RXq1gH4TZFKeI5OZfEUDBq
 2oErfn7sXtywD8kOquTuokmJDLO6VuAHkd/hIrFlWqR7io2PilduUB5FWEDzu5Es
 mkEp2YoSFKggepu2vow2/TobsOGFkioo8qlFNUE1+e6IPSZLmT/Cc86KxUJlsfD/
 OMWmwvRXXVK4Xg8vu2/1HslaxjAlxxeWJ0fTsrQXidI8dGdMXZnMrKBDxvRVkAym
 5Pqc8imDTJ2S7bhzm+2aVfZ7Mz8X0Ok49IZFiQVESdvqp3pWOCXCBXwZXllC7ATq
 5QCkgnUkH7X6V4vteaYhjsqYApNj8lBkv1PUCugpRAmOlzbsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761846817; x=1761933217; bh=8gbZVU9sgtS3voSzd+gbMJkOr4bx8p5iLF5
 gJ0dKylk=; b=1LGr1awf2Gbktxk9gp7PNe7Av8/iObx+QCIBPczjTqOxh5BCEqV
 anPjAh7tGblyydiDWSmT3Cvi6EvGRbnpPhiTBWEC+wDQuiE9TEzFnwZyHyKM5sno
 Nez9GAJMJqmIjl1eQNZqQiobWY+JbQCaqFn0l2UpHUAc1SlSwY1UiG1mrOPoUqhZ
 b87192is+x1fKgGx1lRQlaBW6wV+574mstAP1bAWnbnaaco27FD2cUPZgrSupsqH
 6k0zwi4RjyxiPmyGcq98ozVpAfxp1TIdWM6HSJCH5UmIIaNxSynAzp7DhjEMBpsh
 CljHhYF+RcpYQvvSIhJG7WLMCwvanKnXsvw==
X-ME-Sender: <xms:IaYDaQiZ4GN2JnmM_Ev3sNc2texKOQyInKofujrCOZaTanWxQHJdCw>
 <xme:IaYDaVVFKRVp4M0UrAfuI2jWih2UH9ggpYvM94e18LBgudxmR1Cn1ncH46OJp_5sT
 TWmGPeCZGzFwbuYJKei8cOOoR9Yw2RB-Jra-MwPCgDP_90A-y8H2A>
X-ME-Received: <xmr:IaYDaa3sN8bk9u9EkpjhLvZbLNZPIhf8SKuujRYyLjSb9uzaH9K7LlqvvvICdLcLR7A_vOxh1-VCCJk_GsI4wwEUnIZEKhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekle
 eigeffueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomh
X-ME-Proxy: <xmx:IaYDaTHTgrII89qS2Bqz5W2h_ghmrzXfXYNthJ1UJaH-L5rdA2Qe2g>
 <xmx:IaYDaQjo5u5-VClMXsmtTL4tFO4Rb52M1XbQLw_d4uz1UrFtMw_vXQ>
 <xmx:IaYDaW9EAiz_aeUxubN0iaoyAWMQ1Kd8VCbiPhEe_F7C7MXXPJJjvA>
 <xmx:IaYDafpajQiR0k43tZnZPR_PfrQu9JgwQYP0c37dtwrfIVzuS4Qoog>
 <xmx:IaYDaeU2IKDK3_MVCz0qHa0jw_Qod4rjTxrOxIe7QfQfOneFwLuvzXoM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 13:53:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH 0/2] fix hash unit test for CI
Date: Thu, 30 Oct 2025 18:50:10 +0100
Message-ID: <20251030175329.4041960-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When running the CI tests in GHA with UBSan enabled,
for an unknown reason, a test is regularly going to timeout.
While reducing the time needed for this test,
a fix is added to fail nicely when there is not enough memory.

Thomas Monjalon (2):
  test/hash: check memory allocation
  test/hash: reduce time of functional R/W test

 app/test/test_hash_readwrite.c         | 35 +++++++++++++++-----------
 app/test/test_hash_readwrite_lf_perf.c |  4 +++
 2 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.51.0

