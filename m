Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AF606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fAVismz/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B59F402AD;
	Sun,  8 Nov 2026 17:40:56 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTPS id 2350E40264
 for <dev@dpdk.org>; Sun,  8 Nov 2026 17:40:55 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cdb684859cbso80174a12.1
 for <dev@dpdk.org>; Sun, 08 Nov 2026 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794156053;
 x=1794760853; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uAtmA5KZDSVVqy8sQtgKTtXRvXXfxnMpW/UfFCfCHtk=;
 b=fAVismz/jxFxJpkDwfRn56rkB0VVWjKZMrGMAW3ufwrNzf7goyO/eLq6aovd/GycgJ
 4G8fqrOl/oaryi2pK85bJPewAAgjToK2AViegOQQKyxDDOuT2gvUOljWQPAadbukVYl7
 oROi/sgmYTSWc8gEzSQkSR2FD47Q1sMNqzxCgQoCBKKJKv2Aw6rXwy1UqwzU3rTf+vGT
 HdPUOgS1VttAtM7ZQiT7bPjTWAygtSDQmUTbCYwpT0NO6dbBk0JULWLMEcWVFcD+dGUm
 19I3m6KRgRxtd3TSAAYqwfjpLDVTQ5egdSDkJasrVJjhztV0UK/oasaCwqfJ10FpXQrc
 bgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794156053; x=1794760853;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uAtmA5KZDSVVqy8sQtgKTtXRvXXfxnMpW/UfFCfCHtk=;
 b=od790IPf1xZu9tEqlEGcyjL2OcrfuB9nEiKHdGBGV2N8HZBBch/Z4DUS0QQOrSzONZ
 4ZoOaDQk20TSZH6vsw0/2Tzi/TFXgI+eKQVgFvoRjOadVM6R7hzje0CULFZKezYbKGM2
 ZqXob4E4rfT4G2+K0pFL9yoJJYF2VIWQOWoNWqIzSwCuEjJTFhxDhQ3ImCT60uecscIS
 UNi7FYFyRZ0DcA1B6FWgpBvTLWZ4Gau3hcCaYiiG+d3rg3a/MxdF769E+S2BSysp+2MQ
 fkPf0j/OxOsKSSdOwF2wIiyUov5Prz2TldL6ZTxA3NOOlkFlsEQpkeyxE5+4kymuIWqZ
 XWjA==
X-Gm-Message-State: APuU4Z/MRLgUKbHTvcuOAnN7iD4/+13XZmUeweRkwhJeGZMLDSh/B0oB
 zk86nlD4WEWTL21JJgjtHlumwJBt/07LU4ae1eyCiek4GTvUKYSgPaU150hQ83vrh+o=
X-Gm-Gg: AYBFou2dt3qYOnb9T0vQNgYqf+UK64WhgSilSLYFfvxTznFc4Lzjjq8n7Lwkg1Xf/3Z
 wi/qlRcprGXVpQT0/kNYaxX3FWYW/C6U7w/qy2wSMFpJJnd5AwRUdPmU01ab+AFXM9AIySy8Xia
 pNj4Z2/e1+h6+bRmXBQrmM0wHkgytIV+wJiswF+24351QkN2ushbDKtrOKRgGHKv0wB1z3jYI3I
 MewOTnVeq9UClb0VXeCzbk8thLE+B3+p0fUnCjuYKGJH/ONv6G1IUQpzXRdMW49v/0nmjsO7ntb
 C61TJ7wYVHl8V3/ll+crWgBAtKBMYmwmpoF8/K7jMXOjLk+I7sAT5qtnjQgu6Am7ocsSMT3w3Wq
 f1UMIcBiGl9MRV7eH0i+MlINBMmJU0iNaH4Oxnlky/tSDg14yBabSR8/mZ/rQ0WdFWHoDZtJA8w
 iatSJKIiGqC4wt3ajIIhAIAvDL9bAfYtUkgPYP1hmiyLD1ed2EuVrZ9E4CQLVIpjrEbIlAzjXcF
 gAELhZfL+HwG+CmRAR0iRHXWnu8EIVawkWqe6f1YSXwCiI0LFVSE1jKo2Vg44s0bXgZIDuuFbMB
 TOxCP7Vft5QCX3UIkGTrPdMgGKp6U3LTTUqirBH20GT5OqblPlSGnntE/0YntJFinV3+UA==
X-Received: by 2002:a17:90b:57cd:b0:39e:6a80:b799 with SMTP id
 98e67ed59e1d1-3b12d3dce75mr1701654a91.41.1794156053406; 
 Sun, 08 Nov 2026 08:40:53 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127fad1d3sm3485199a91.11.2026.11.08.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:40:53 -0800 (PST)
Date: Sun, 8 Nov 2026 08:40:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com,
 stable@dpdk.org
Subject: Re: [PATCH] net/txgbe: keep flow rules per port
Message-ID: <20261108084051.66ebbf3e@phoenix.local>
In-Reply-To: <20261108160021.31789-1-zhtfdev@gmail.com>
References: <20261108160021.31789-1-zhtfdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  9 Nov 2026 00:00:21 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> rte_flow rules for every txgbe port were stored in file-scope lists.
> Flushing or closing one port freed the rte_flow handles of the others
> while their hardware rules stayed programmed, and probing another port
> reinitialized the lists. The same lists are used by the PF and VF flow
> operations.
> 
> Keep one flow list in struct txgbe_adapter. A port disables flow
> director only when its own FDIR rule count reaches zero.
> 
> Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

I didn't look at all the details but seems to be good idea.
AI liked it but found some related overlap

Subject: Re: [PATCH] net/txgbe: keep flow rules per port

Moving the flow list into struct txgbe_adapter is the right fix, and
checking that the handle belongs to the port before touching hardware
in txgbe_flow_destroy() closes a real cross-port bug. Applies to
v26.11-rc2, builds with -Dwerror=true. Fixes: tag is correct, the
global lists came in with 5c2352b9ece6.

Warning

The new fdir_info->n_flows counter duplicates state the driver already
keeps per port. Every FDIR rte_flow rule, PF and VF, goes through
txgbe_insert_fdir_filter() which adds a node to fdir_info->fdir_list,
and the delete paths remove it via txgbe_remove_fdir_filter().
txgbe_clear_all_fdir_filter() and txgbe_fdir_filter_uninit() empty
that list as well. Duplicate adds are rejected (-EINVAL), so the list
length equals n_flows in all paths.

Drop n_flows and test the existing list instead:

	if (!ret) {
		rte_free(fdir_rule_ptr);
		if (TAILQ_EMPTY(&fdir_info->fdir_list)) {
			memset(&fdir_info->mask, 0,
			       sizeof(struct txgbe_hw_fdir_mask));
			...

That removes the field, the two increments in txgbe_flow_create(),
the reset in txgbe_filterlist_flush() and txgbe_fdir_filter_init(),
and the "if (n_flows > 0)" guard which only hides an accounting bug
if one ever exists. Smaller diff for the stable backport too.

Info

After removing the TAILQ_ENTRY members, txgbe_ntuple_filter_ele and
the other *_ele structs are single-member wrappers. Fine to leave for
a stable fix; a later cleanup could store the filter structs directly.
