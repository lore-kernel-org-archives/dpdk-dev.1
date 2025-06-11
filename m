Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1354C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 11:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3269402EF;
	Wed, 11 Jun 2025 13:53:03 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 3E16B402E5;
 Wed, 11 Jun 2025 13:53:02 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 7F87D11401F3;
 Wed, 11 Jun 2025 07:53:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749642781;
 x=1749729181; bh=sN4VxyqC9ApkPefKIG4OCSxk7rzV2NLiTAjFqShWxmc=; b=
 GlwoPNNxvxvIxZi8LteAlV0RTFiBHE16R7FMs73DkubiPwo1I0tRCkdFEUOWkEyk
 NqphxYAdlgWiUEce1948cqA9R9wV+suvnDOPvhYmFOlhK+UR8BZYZiuoWmoMbKln
 uatXqzeTkkA/mv78Q8zOjaKFT2BOiBd4in8GTWiUyCbhbRLKMGN6exPIUbAUunvO
 MaTQfy7nAqCeSEq0WX6kIynlFdy17WqVE/dOR6LQtg+snqCQDcJOc6PBSx/UhfQ/
 BPEv1xMoaBnHwWpBuV0bpcbWv72Ko7otr1AXB+Ijsw9CsYsqjiKr+sTf4bTZqn84
 Fdp/+iovoGstJ5ygdlQbDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749642781; x=
 1749729181; bh=sN4VxyqC9ApkPefKIG4OCSxk7rzV2NLiTAjFqShWxmc=; b=D
 coHUnN9UPvxmCEZams16egXCAVeOw/uYLktF13kUkRqao9cnUKdxltamZNs4FsVK
 dmbBz3diYjmghKO50KxR/1IdnKw+khz0V/7GkhgJ4g3IkRFcpZWVkQ1ZKZjLoQDp
 9N7NzjcYyFfBPybwnrY/EuY9L6k8210sE7znapyDVvn+gwXej6M6tjolPJDp0V3m
 GKc3Z/jMlnYTpRKqVqY9K32YnFxyC6qlchM5JWHM4TVKt/ULVA0eHRTIqe8DWJBC
 xOmv96I5SNBE06va9FlyxeC0R8xwM5VRY/GJzpVvG48m4Crok9m2Y+HLLfQScKCg
 wvisSgM+6kKsVbZlQY2QA==
X-ME-Sender: <xms:HG5JaH0azT7EEzR6htnbwxsu9l1NhtUtBYo-6MZA2ibC7yQ4fBQvqQ>
 <xme:HG5JaGGxUhyxTbycPKkqwDvVEEPL0eGqSwNhcmeqRzX5Mxc1B51j6Owulztgz01XW
 O4ajcJ5MZ_3qGs8hA>
X-ME-Received: <xmr:HG5JaH4EX_XOiPqgCRuXJpVCKVGww3Ob5cWhSCk8u0hs_PDwkIxjf---5SI2sHVvG8oTT1J2QBbq9KeAZ8PSkoK6jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeekhfffgfeggfeujeeikedttdeg
 ueeufeejfffgvddtjeetgffhueduueeuhfdunecuffhomhgrihhnpehpvhhsqdhsthhuug
 hiohdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnh
 gspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrihgv
 lhdrohhtihhlihgsihhlihesieifihhnugdrtghomhdprhgtphhtthhopeguvghvseguph
 gukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthht
 ohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
 hsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehr
 vghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepughmihhtrh
 ihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HG5JaM2JiYQ4vxqumMZ82-RTgBAzypocyPSxnuhZ3_WgGI_vzUOORw>
 <xmx:HG5JaKGenQvKF154E2-S_8x9GPaofGk-_p43S-hGkRhdKn7rKxtGsQ>
 <xmx:HG5JaN_M8-lxbxzXQEeoCauziIzG1lWzJ9APvDPyznr_QvJwlifl7g>
 <xmx:HG5JaHkmEFk6I6GQuA-9i1U3UNPGBT3jyU-6cuuQuv0MS6k7_je3Mg>
 <xmx:HW5JaG6jfjCLeSRKQv_tNQFYV7lkpXhCjruefubXHxc9eBzJ82ehhBXX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 07:52:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, David Marchand <david.marchand@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v3 1/1] pcapng: fix null dereference in rte_pcapng_close
Date: Wed, 11 Jun 2025 13:52:58 +0200
Message-ID: <6217241.6PsWsQAL7t@thomas>
In-Reply-To: <20250224164031.587829-2-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250224164031.587829-1-ariel.otilibili@6wind.com>
 <20250224164031.587829-2-ariel.otilibili@6wind.com>
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

24/02/2025 17:40, Ariel Otilibili:
> rte_pcapng_close() might dereference a null pointer; as example,
> PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
> rte_pcapng_close() might receive a null pointer.
> 
> Link: https://pvs-studio.com/en/docs/warnings/v522/
> Link: https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a9942/app/test/test_pcapng.c#L438
> Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>

Applied, thanks.



