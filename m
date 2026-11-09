Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8B606A326
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RuAmNKXP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C270F40285;
	Tue, 10 Nov 2026 14:40:54 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mails.dpdk.org (Postfix) with ESMTPS id E339E4025A
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:02:11 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so6420995e9.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794232931; x=1794837731; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ai2q2fjmLQ+s6Ncu2jAQErMRqsrJxVbOduJ12zJwzuU=;
 b=RuAmNKXPxCEpn69Cg+niIxB2YDaB6k4cIUWM+u1CIbzLShSWPjwsIumN+AuAVFonWI
 pdCEm1vYQKHXJgQRfVMG4Sjni6WAt82Acqk8KUtZ4M07oANUpQ/axwQcEgz41rL2YZMy
 sAtpH/nAn8EoRVUGVifNiqJN1b1iXZ/TdKPImtX74DeBqXATZmAv4bL0j5yqBCtUUTtZ
 fNrLDtrM9GIOeVjt8AOevbd/m3EQcuFnmRY3nES6tkV6qdD8xG8mq/VbRnyTbOuWIzUq
 PbCFy3yhGwhthaJtGc9YSyiS7odOBPHJAZ9iDxTI134Egp/P8SFwZ2IUuGLwBCGsUNwO
 t0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794232931; x=1794837731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ai2q2fjmLQ+s6Ncu2jAQErMRqsrJxVbOduJ12zJwzuU=;
 b=EeqGK7ENeP7+zAaDOWDVsxx+eN6wyw43pvHuUw31S84FLPtwwB0HcEyl9pzr9mJ96f
 VlAHKjScOwo87OLTAKZC0YKLGGXs7A73Off191MV2CNz6Un9cyPAVKCaYQ18d7ywqBY8
 0vivE3gWIjQiVuxPeXbLsCqpPvqO2gZSXEgJ2x0enxeHTq/UFsMGDnfwdCCZiOxFOm2d
 H5GCrgqsHC12OUP0UkgXRZY6ez8TrnU4um/KzHXPNNFYObTn9INN9yssrPfU+JOgfw7N
 HeLbJUMv4F0B0XYuTjya3AHolGEgYWt2E7sF0Kg7gu5upqwBVCtUqJ9JmZUxIfdI6+N+
 BxeQ==
X-Gm-Message-State: APuU4Z9tcVdQOMjZ2atmJqqBZaXBdbrtpWeBkSWqMZoan02HowWDN1ut
 SRrrtLjU9Js/aBGvHxzA27B4zmszYoLZ58ow21suI6wRrGnonwupZtnX
X-Gm-Gg: AYBFou151e3Dg1iOCJRMQ0I1YHCr6gb68z8h8H/5ZDu+sWsKMzSxrBIhrN21+h5VXIL
 rloMfD3s8qwBfW7YYCXnoNqunYdBIg14KH4n+jmPCl5JB6Lp9KoiiZ+ZgcthVUU2ZTtrkVqaRwe
 3cYsiIpLtfzP/2b6coUqs9HAGQwGvItabhQMFQCU6REYspc2rUTFcuet9+05zbAmKHX5OnZqc2S
 W9rn1MLEZYD9f78GQEoQkvFjGTUwtLmtzlGSGsgQ/JkskussiqJntG8Jb6ALRKONZEunPp9Z3k/
 +gKiQyjgDf46XUBb3uWq6xOLU1tmmpOTeisECtxnTiVvOYRubLjrsBoq/CLnReD3JdAAPsM8yP+
 ictUe4baXN15HiA+DXKhJKhz/9vUOTOH/MgVniWtGtoYMTJg/w4BWzBkZIl/wuuGTsYmHXhscRn
 tQdm8NpwNmV45h2cOPSUe6CLKrB5x8asnP25BTWQMvKrEh8KX2rrrrhrKE4HlnKLuADlFB+EO58
 XhKQbbCxZrqnnXBqlfuY/izLGYYKo/i4e7iSazw5t2Oh+ONqr+ONmJ1dYyvnvkpTO/BeAJPkqjX
 WiheKDiXF4NyHhyqdgEr8uvNkE2kMOgrAaqQK0+0X0j7ZiFZ5InJEfFn/GB2iWM7YfLa05QO5Ll
 5I8k03qGc1+UB3t3taD/XWtKqUg7+ICLrhCqn7oklAPXablk=
X-Received: by 2002:a05:6000:4b0f:b0:492:dddc:64c3 with SMTP id
 ffacd0b85a97d-49583deb6d6mr7447961f8f.41.1794232929466; 
 Mon, 09 Nov 2026 06:02:09 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597e00d75sm9976866f8f.58.2026.11.09.06.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:02:08 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org, Long Li <longli@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Aditya Garg <gargaditya@microsoft.com>
Subject: Re: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Date: Mon,  9 Nov 2026 14:02:07 +0000
Message-ID: <20261109140207.4029126-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <SE3P153MB18482F1674C5450AC402E0C5BB732@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
 <SE3P153MB18482F1674C5450AC402E0C5BB732@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 14:40:54 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wei,

Wei Hu <weh@microsoft.com> wrote:
> App threads could get stuck as long as 15 seconds waiting for the lock when
> the device is in reset. Is it better to add following?

The 15 s recovery wait in mana_reset_thread() runs with reset_ops_lock
released and dev_state at RESET_EXIT, so a caller in that window takes
the lock, sees the state and returns -EBUSY at once. The lock is held
during teardown (dev_stop, the RESET_ENTER request to secondaries with
its 5 s IPC timeout, dev_close) and during re-probe, and a caller that
arrives then waits for that step.

Your early check fixes that: both steps run with dev_state already
non-ACTIVE, so the caller returns -EBUSY without touching the lock.

One window stays open. A caller can pass the check just before
mana_intr_handler() takes the lock, then block through
mana_reset_enter() and, if the reset thread wins the lock next,
through the whole teardown. Checking the state while waiting closes
that too, and it is no bigger:

static int
mana_reset_lock(struct mana_priv *priv)
{
	while (pthread_mutex_trylock(&priv->reset_ops_lock)) {
		if (rte_atomic_load_explicit(&priv->dev_state,
		    rte_memory_order_relaxed) != MANA_DEV_ACTIVE)
			return -EBUSY;
		rte_pause();
	}

	if (rte_atomic_load_explicit(&priv->dev_state,
	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
		pthread_mutex_unlock(&priv->reset_ops_lock);
		return -EBUSY;
	}
	return 0;
}

Outside a reset the lock is only held by another queue's doorbell
write or event read, so the spin is short. A caller then never waits
on a reset step at all.

I'll send v2 with this, without Cc: stable, unless you prefer your
version.

Thanks,
Orgad
