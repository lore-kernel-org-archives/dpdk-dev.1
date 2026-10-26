Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F808606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=r9YnVPgZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEA9F4042E;
	Mon, 26 Oct 2026 18:01:19 +0100 (CET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTPS id AE37E402A3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 18:01:18 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cd6a7e1f4e4so1164660a12.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793034077;
 x=1793638877; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kdt4r4P0xeabassjN6+3y3mcftbMHR+dUo3AkcqVfkk=;
 b=r9YnVPgZ/UJGPj9TeHHuGh8FnxcUaYWkp875BjcuVdbVlLO3fBSCfEq+Fw7K7+RiD8
 ebheT3uNTUgHQgv54DIh8Fz6xuHBwdZQZPtddi73CusuZMnjsGipX5X/P2LfAtMeplBF
 /TfYsE5tyLLpslso9OYO1b8gKPGEKOra7PHTaAIxexnOAzoT094P2A4eG2DYf1lmyezR
 y7Mg7mj95cezK4uE98K9+HuclmwX9deRW2QFCngIwFkAFaLXYgo33kds8M2FxPi4ZLcV
 VxicY1cAQaU5rAkEdyo1u4RbgVL1kxljV71t5QUK54KFYV7njnpND5Uf0JVVY+I6yXae
 8Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034077; x=1793638877;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kdt4r4P0xeabassjN6+3y3mcftbMHR+dUo3AkcqVfkk=;
 b=XT6AmCsHbX/N1TOgA7yYwQqoOBlpYc2T/dpbMXyEkTVzvEJePf3+66UbgEytWkFszW
 Bc5dwKfV39kRNi/i+1O1BNsTgLlpDbcmweUFYXHZfkHRMm6IYNZsy9GNAsmOJ6cXAYX6
 aDXIoCPK6WJT3DaiQzBtMluvp2c7B85cUwNbqhvI9r6WQlVcP3aSFt8YvBAtZLoJiLvR
 jIfXOYgD3G7j2H3SPSpinogn5xw0Rz9G14wj6hdixq0c+58LzZwMa1Vr3T1SjgszHI2e
 l8hsTGfrDYGOj8oj8YMfZVshNwOLzq0mivKsMQ4DTq262sV+8CYmqWPc0IpRSQO3KaTu
 Xdpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDxa5Jxf8zialZqW8bE7qXQPlooFwn4uaNYeo8oM2tSGfUE/sOYtr1SGLoK0S0PRzwmPE=@dpdk.org
X-Gm-Message-State: AFq9FYIRG9NqcpjKN9QnnfDBAyTrgqKcIwNfzZGm3L3ADHwafsV/Qgks
 1uPgGIyRFUzJtDHfEaxh8/EfJQLKUi3Zy6sXNjRz//819uI8AWpQWCp9ZGCRnAO8FhA=
X-Gm-Gg: AYBFou1q+rr+xcS7xw0JkEmNEJ75EbYL0stLHVttiP9iSqabGUptPPlj8MYJbd9wPXZ
 cf51m92avevdSZ1sltAou2Owxc+hfK7qa+OtAXTKZgNUKqzUSD8y4RdC3KK5Jd3/N4feeNvneuS
 muKc0pnrQIR87A1BXqre4ibU2eNz93d4gaMff6VysRBXIMejBgNDmwaVBsNfl+nvD829B/wvvCA
 c2nfWHh21nVvgMZ3Ew5KgU8DWkykYLiq8k2ZpP3gKCjhltZrkLrm5XYpUDnBnhTCmFLAKsqAXYy
 PRa+6a432WgXYbbyd8cJFzf6wQAV3XAye9o4UkwFF8IpkGb04wfw3Q0ZfuUXNh9Bgrnj7oR6//u
 lvz+PCCQ+qleaMTKMR+g9Itw60pbAn8ObDhMne8TytP3wdshA3PaSApIDcEGbz865/FbxaKz27d
 GYkGPzbFwRIOSyX3G4CjXCzx0lUfp0Op83Q1CpQ9jtpK/D6G9eU0w8AANRVYjHJuXip5oLktAdL
 r/gdV/mmXOmzakMWi7c/Sgjibrjdao2tFRutWiFwQyjpzc7vXEliL80ITVxz/IjKsMYcuXdaGBx
 QlMHT1Isp+Auxfu3SAOv0w==
X-Received: by 2002:a17:90b:224a:b0:3a0:c276:1ec0 with SMTP id
 98e67ed59e1d1-3adeaae8d12mr5901428a91.28.1793034076866; 
 Mon, 26 Oct 2026 10:01:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404432a5sm252208a91.9.2026.10.26.10.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:01:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:58:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chen Zhao <ch3nzhao@gmail.com>
Cc: weh@microsoft.com, thomas@monjalon.net, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/netvsc: fix event buffer leak on realloc failure
Message-ID: <20261026095826.5a47a57c@phoenix.local>
In-Reply-To: <20261025014634.3295418-1-ch3nzhao@gmail.com>
References: <20261025014634.3295418-1-ch3nzhao@gmail.com>
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

On Sun, 25 Oct 2026 01:46:33 +0000
Chen Zhao <ch3nzhao@gmail.com> wrote:

> rte_realloc() failure overwrites event_buf and leaks the old allocation.
> Save the old pointer and free it on failure before resetting event_sz.
> 
> Fixes: 1f2766b7ee02 ("net/netvsc: resize event buffer as needed")
> Cc: sthemmin@microsoft.com
> Cc: stable@dpdk.org
> Signed-off-by: Chen Zhao <ch3nzhao@gmail.com>
> ---

AI review says "good but it could be better"

On Sun, 25 Oct 2026 01:46:33 +0000
Chen Zhao <ch3nzhao@gmail.com> wrote:

> rte_realloc() failure overwrites event_buf and leaks the old allocation.
> Save the old pointer and free it on failure before resetting event_sz.

The leak is real, but freeing the old buffer is the wrong recovery.
The old buffer is still valid and usable for smaller events; there is
no reason to throw it away. Also event_sz is updated before the
allocation succeeds.

Use a temporary and only commit on success:

		if (unlikely(ret == -ENOBUFS)) {
			/* event buffer not large enough to read ring */
			uint32_t new_sz = len + len / 4;
			void *new_buf;

			PMD_DRV_LOG(DEBUG,
				    "event buffer expansion (need %u)", len);
			new_buf = rte_realloc(rxq->event_buf, new_sz,
					      RTE_CACHE_LINE_SIZE);
			if (new_buf == NULL)
				break;	/* out of memory, no more events now */

			rxq->event_buf = new_buf;
			rxq->event_sz = new_sz;
			goto retry;
		}

Drop the Cc to sthemmin@microsoft.com, that address is dead.
