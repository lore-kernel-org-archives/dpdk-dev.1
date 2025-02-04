Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492ACC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 760C2410E3;
	Tue,  4 Feb 2025 16:59:33 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id E85EC400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:59:31 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 67F7F11401D0;
 Tue,  4 Feb 2025 10:59:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 04 Feb 2025 10:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738684771;
 x=1738771171; bh=KHe4nVJbc/ZEjMHZPZmSfAZ2/hX2X3rj50vbFskzEDk=; b=
 Qt1gxAbKmQ9jiel2jtFcCqoDmS1nGgEJaa5aVnnn9M9oRc39jfDaOPmhemDA0RTh
 E0K8Rip4vjCflExDn/RdXCi5ehw5gMzbtUlydiOwJ9ZDjZ+uFHyBEwWqNK73e62L
 7uGjlJeAf15ydF5cdMWd7dPqoL6s+d89fGnv67+c3/HwUjoNeBU4u3UA0vcWz51Q
 K39iiyJjM+eSZgyGhfcwh87thA4sEgBbceZuzmnvx3Vi0r+y/vWl1Q2VeNAMcGMF
 yqqlDiXKOWA9qNpef1iENEwPNi9uzJSi4WMACTPLCf2D2MBNZ3SduXvBvU7YWauW
 fLvURLYiRBOJp5/+E6OuRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738684771; x=
 1738771171; bh=KHe4nVJbc/ZEjMHZPZmSfAZ2/hX2X3rj50vbFskzEDk=; b=A
 6phxRJwFiVCzFlDnNAOXOislmm9RaY8OAguENe8KlEHY7QHIv0NMOTg0oOZutdO+
 3fWHuj6onCd87w5Pm/uqXXuUihhoHkcbLr46mIUBbaG+BWgdz7R+KqZ0of8bTkDk
 MnWEsWhYgLpY8QEebyh4FW93ggqroxLYx4dFy493rzptAJ0B4AvZiSMasogKyA3L
 14DM8fe8IUwTxnJWJcfQJ8qhsyYnhZheVaUsqsA9jXHnjHYJwMukRDWKuRVMbR5z
 1CWvOmnWByEZwtS+sRS66PvKKDzjVndOICFtYpz0Q61bGrKNlabzOji3nopTAoWO
 dCOHJvRosnkQn/MYlfgKA==
X-ME-Sender: <xms:YzmiZ8U_VQCMr-OJ3qKK6ivpK8lcO1t_3mPJ0oPIctMgBFePcdU2Jw>
 <xme:YzmiZwlBKaNhMq_1xdvOAzvhBvGs9e4buuR-VY9rW9vfMhD6L6EcGT3Rl0XFohSg5
 mhXNFSmzIRmyo9tdg>
X-ME-Received: <xmr:YzmiZwYfq0I_B13JxBZHRA8cOtlys6Mr35mZnMxOhTMkc02pB0YyI-sNlsaxYoKH3uuPJxV5NtJqQEVwCCaNGLiUSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvh
 hiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnth
 gvlhdrtghomhdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghrohhs
 ohhfthdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghroh
 hsohhfthdrtghomh
X-ME-Proxy: <xmx:YzmiZ7UFJzPmJHMG85IKjHahZiOep5qErpskbL_zGGJIxfcRCsjgoQ>
 <xmx:YzmiZ2nQ3Ut3LUaKUOJuPBjmo2MmkDfXPMB-5I_MawvVyqYc_xXstw>
 <xmx:YzmiZwevYkZsK-DwtuOO7opth_qihzUWZ5yS5wQcjYEc9ejYNIGtVg>
 <xmx:YzmiZ4FhVoC12O9yaO4UPNZ_cjskR174XJr5plIvFbfdgr7Lz-ZJCw>
 <xmx:YzmiZ9uYSlDkLEi8kh5gvmBMe3Kya5i7X-fzmclCG4qJNpvJdynpWs6C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 10:59:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 roretzla@linux.microsoft.com
Subject: Re: [PATCH] devtools: forbid use of compiler pragmas
Date: Tue, 04 Feb 2025 16:59:28 +0100
Message-ID: <8281045.JRmrKFJ9eK@thomas>
In-Reply-To: <20250130083741.3258965-1-david.marchand@redhat.com>
References: <20250130083741.3258965-1-david.marchand@redhat.com>
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

30/01/2025 09:37, David Marchand:
> Using pragma must be prevented to avoid breaking builds with other
> compilers.
> Let EAL use them (like for abstraction macros).
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> +	# forbid use of #pragma
> +	awk -v FOLDERS='lib drivers app examples' \
> +		-v SKIP_FILES='lib/eal/include/rte_common.h' \
> +		-v EXPRESSIONS='(#pragma|_Pragma)' \
> +		-v RET_ON_FAIL=1 \
> +		-v MESSAGE='Using compilers pragma is not allowed' \
> +		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
> +		"$1" || res=1

Acked-by: Thomas Monjalon <thomas@monjalon.net>


