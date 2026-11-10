Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7260A262D
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FoBEX/Z2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B0584026C;
	Tue, 10 Nov 2026 17:54:27 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTPS id CEB494026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:54:25 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ed1e9ae5a8so7810745ad.1
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794329664;
 x=1794934464; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BO+R9v45udhkem6+lxCqVzFbfrClfknLdmvHz1gOmYk=;
 b=FoBEX/Z2+xEHrFV8TQrDu5XgcqePcJOlcyDbLbjouOFWAUCHZ9DDMixVSpx0J8waND
 PFzVpSYdU5pjztNqS78ztGgrt//zQJn2ZeRKBXa4Cv4SKhLMIz5W+aCWxd4cfavpTYB/
 lBis5acJwSd0CRtHg5g4iINAH7n5/vDgyZrF9+Ybg4FqTdrCMPtpYS2BcZwOyO5TU0Ow
 iv3LdPfhfULamjFEfTVMULo8avNdc2KPiEcrWPJaSbGLPAFulGTBk1FAmCV4YdgCr6B8
 xP6BK4pbX+mtx5b58ffhPJrU3Ng1ZmOQNFZMmPZYZE9XcNb7bl1YHYutQGPk8pdMcCYT
 5teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329664; x=1794934464;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BO+R9v45udhkem6+lxCqVzFbfrClfknLdmvHz1gOmYk=;
 b=hESYC1xb44MR1Buyg/NgD1/1+KoMG/yMCNtqWWjBRzx+HTnMKhpP0Lhy7yvkRwFKAX
 XTgeR1odl58DY21OUz6waj6d9T/2RjjH1kIjaJcSVsydt6hSbUUtTLck/M6GX9+ZnIjE
 RFUzMdidU46AhOKHygt50RqPOJwKKElVAteoxojOJY1RxaJ4tJBkpkPV/rBx2AfYtMCQ
 8Ppb6tcsryrq8hJ5DFuZ5CxZs+SMtfiNrMkIW9stO25kBvBVmWC+VqpHjXixHplYwId/
 dj4jPPbG0LEBji7NAAe5qjZv02nNfmorjs65i6lStpIQt6VuWUMb9584/PVjsCc22NRv
 2GGQ==
X-Gm-Message-State: APuU4Z/6F58OjZV0W7SW3A7TUfKiBarOP6XiLrgXhy9yT2FGTwAe9JYA
 O0tgyUkCXYldR+Mtg/JjR7F0G8ZKra98XOJ5WdpyKj0UyQC5cSHaB+AFs4rmT3y7q0c=
X-Gm-Gg: AYBFou1a4xGI6N/Vf9/Rh2HCxst3dB3dkWGwLrVLwqHN3Fp0OleJ/P817KcDx7hu5IN
 wbc9feot4pAJcjmZOEfpzRvhFmJqyCWbU3Y3aLN0Ij2M/DjCMU7x3N4sYU7/e+Dbl4AQ/E9ZUgn
 x++4LVmzQIsB4mU89nVkYqIepi0kjxVpQXoyOM3GbYweBvUB9JMtueDIQE9KeyXrtp12wu9SAUe
 Mp0JyABJ59sUqY6EIVgvOPfZhy0fzWtOG2nU6VXUgkeUuoyicfPOHZuMuYYe+cySaA8xeseR3AS
 QrFrXTSxAwpPXzOXE88L1VdVeXiQEvHX97AXhEGYk8H3374++grfW6A55Hf9x9mNF64ni0HzbpY
 VY+ufjK5hSUrJ+nIQ3gOqJhgSg5DD8mKIm4Y9zFu/k/yhUfNyVjnn3QFvA6zW9x5qplhDljLpCQ
 UASSLK/tz0nAhc0XT9fTtBaAt/CW1yJ/k5OtwpD5UmFfhatQ6NERN9f8kaNY9LLB64XPYL6OBT1
 Pux6pyABvqtAE85awMgqZtpsi7x9X887TYyUE6F5sGfIcouZPPnh4m8ETjbLytl9ao5VjGLH+pa
 bjld8RCA12Nly39fgkYzrs9rL1ymFNshoZiY+sOpp3J3nDXjjBlBVN6AaPx4AoMhFHpEryU=
X-Received: by 2002:a17:903:1a2b:b0:2e9:5507:b538 with SMTP id
 d9443c01a7336-2edb8fb38f2mr30221985ad.3.1794329664136; 
 Tue, 10 Nov 2026 08:54:24 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d4b93csm11369315ad.14.2026.11.10.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:54:23 -0800 (PST)
Date: Tue, 10 Nov 2026 08:54:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
Subject: Re: [PATCH v3 1/2] net/tap: fix FD leak on netns change
Message-ID: <20261110085413.6e0bcdcd@phoenix.local>
In-Reply-To: <20261110100308.3190833-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261110100308.3190833-1-david.marchand@redhat.com>
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

On Tue, 10 Nov 2026 11:03:07 +0100
David Marchand <david.marchand@redhat.com> wrote:

> When a tap interface moves to another namespace, tap_netns_change()
> calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
> without first tearing down the old one. The previous LSC netlink
> socket fd is never closed.
> 
> Defer the full LSC teardown and re-registration to an alarm callback
> which runs in the interrupt thread but outside any active source
> context. The alarm switches to the device's network namespace, tears
> down the old LSC handle, sets up a new one (opening a fresh netlink
> socket in the correct namespace), restores the original namespace,
> and forces carrier state back up.
> 
> Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
> namespace switch logic between tap_netns_change and the alarm.
> 
> Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---

Looks good applied to next-net
