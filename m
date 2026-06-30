Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31597C43602
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 16:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07EE140655;
	Tue, 30 Jun 2026 18:11:06 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 82ABF40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 18:11:04 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 30A1E1D000DB;
 Tue, 30 Jun 2026 12:11:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 12:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782835863;
 x=1782922263; bh=l9zqaBxayq4X8AEVqZ1gbAp/5WE+zDvalEgb3NsCZqM=; b=
 uFqX47h5lvRit9ixgh//85lajegfoTV1CMWtiS35z3PeBvfHPKAiOMiFDvobe5sA
 Zok+kNjq+O5H+sCTUJq1I5Hjyw0TQWCdl9W4vSHgyvDOvna6PwVSMhE5ZZTbRX19
 ZdQIbMWvg07/n+7nAEKXajQvx7/aGqIfcRs5oWvPAPwUN0apISayDQqGbY3Pf3Kg
 loJRD51k+oeEhl4jR8ZQKfQCvfPvcf4BQoT06otWBiTeGuDbOph2TSEhGXZ9L06d
 oDk4E/eewzNVTSE/5h+MEhw4qonpitXj4NCMKTgbOURk+xJOUk05gjgMGdxlavs2
 NE+lsJ1GYhaC3EUO5ysqUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782835863; x=
 1782922263; bh=l9zqaBxayq4X8AEVqZ1gbAp/5WE+zDvalEgb3NsCZqM=; b=T
 kl1UZX5EtxDKTIdxgDcHscyf2Ub9dXLAxPyOrjNAi9do9vfhXfgOEK+LISCU80sN
 ithZwVzOqCFTo2jtd0YubmgtEdnafYd8THoFRMlDDEfDLKij8juvqjc/ie1XAU8S
 gPOTK2QZlDPWB+xNEeQwf77DkJ5e7zVYMKC8sEmigdBFIYJkTISvEK4OZmGykVbE
 zIPOf3T7Brekmvch0ooY7nv4dCJhyBxvHiV2LXfg+o8EwTWd91fAcmbcpdgJ4ON5
 Zabmfqi6jfW6zujp8l/OgF0k+aPu7X1ILbW6trdX6oOsNO2uwlWXlhhdyhg9Q5Of
 ELuTl9Z+daLahINxC68dw==
X-ME-Sender: <xms:lupDaj7zoItMotJ7aGlBfh3k1ZxtZ4ZAvRSJaAsc913GuzyTfL-6dQ>
 <xme:lupDalMy5NAscHWMVqKqZukSN95TaYOBqaKUi_Iid-vYiTrVWdYWNx5GFUSPRb51i
 TrQcUroS8GtruSBOM_PrWjtq9y-yYVB_9gWp4Aq6bIkTtujU0-P>
X-ME-Received: <xmr:lupDatMI42MYyxVMzyYyPcLkAMXpM9U2FO2iMnA1EgNzHhJMDTnnbAua0kQySzubRXTWMB9JuMUvSZuOcYykQrEF3A>
X-ME-Proxy-Cause: dmFkZTFS15ohObmckQ0auIekp4lWDIKMyYpJnAdqCvsLhRbCJ5C5OqThZRmOcOG5Mltruk
 bAofoGQNwnGbw9/6kDF9sIpuRNL74td9lH5iRqiQ2CroW2uAqdiFtI+zrR5vvf4ztx8YzF
 Zum8uM/qGhzMoYz4B+96jdU8eJ6KcklhJmnlSRSu71ljJOCrXJ8fZgp4+hHfjfecXthZPT
 T1Vap6wc5IgsWwVhWHT5wDBj974r44o2sga1yTdRYEiEc/TfzzPaoxCTlnaZFwxJ7jILle
 ywDEkIYrQcMAQTL5iNEB8lFMiMQiF98CTRmSq+8L1kRYXZu/w4ME5dEY6QNbPmgWQwYnsH
 iYsMPHG7O5T4t9vIA5N1hU4BJgno4fRnEaD+AjVkkuRbbRyOmNBKzoQGMryMbQVEzQRt0q
 H+7alQSIapji5h8N13AueOjHm5EYIJ0yZpCkzyWpaqCGjBQAIyITTy0ugBksIXLo8ddGkU
 doLeKp0b3l5PLaWqnPxkTQ+R1SldOXE7OqgxE+D0vhUoGsFLaTFZAHoxSeElfGYYr1sQWn
 dcdhVhxlGJQ+AbfxHxbo55ax8iJHIZckWv4luME3dQfOYF0bauCg/W2DEaoSLSCEMyyUG4
 sihGGZh49PFApWeOjTlJ5Tzsm9BSuC66Fqcv52s89hlb+qleNaAO4oA+GK+w
X-ME-Proxy: <xmx:lupDal_zr3YT_MDEzcLWwlnqkTOlSJ9ZU3vlyhi3Fko_m9Wg5Nngcg>
 <xmx:lupDap7vbo-AkF-UsGxoutN7XFtzV6MgQdcCndnVjUhTI0pRtZOM2Q>
 <xmx:lupDak1DBs8Qa2lM9zxQWrE3U7rbQBWFkJcU3CT6_ruwY8TEjUV2tw>
 <xmx:lupDaoBT5ICJS990O_jL5k-9CWDiCOE-LC4ab11GFfYTbW0lHD87ew>
 <xmx:l-pDagplb67FvXSTJ5KSTAg2ko08ayKk6yhYBdruABmsqRjOs99hFwvp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 12:11:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] doc: updating doxy-api-index.md and doxy-api.conf.in
Date: Tue, 30 Jun 2026 18:10:59 +0200
Message-ID: <cesJxiasRY6aqEM1iZ_leA@monjalon.net>
In-Reply-To: <f0e4ffa90e57467cb292d7888caa697e@huawei.com>
References: <f0e4ffa90e57467cb292d7888caa697e@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

Hello,

30/06/2026 11:03, Marat Khalili:
> I noticed that a few header files contain docstring-like comments but are not
> present in doc/api/doxy-api-index.md and/or (fewer) in doc/api/doxy-api.conf.in
> There seem to be no checks anywhere in the process that would make sure these
> index files are updated. Do we even care, or is it unsupported legacy? If we do
> care, would a check or an automatic generation fix be more promising?

Some internal files have doxygen comments, not sure why,
probably to run Doxygen manually on these files.

In the scope of our public documentation,
the goal was to document all and only public API.

If you see some public API not referenced, it is a bug.
And yes a script to check this may be useful.


