Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77085D29C58
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 106F34042E;
	Mon, 19 Jan 2026 19:24:37 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 24568402E2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:24:35 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4801d21c411so15327165e9.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768847075;
 x=1769451875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAc/3tRc4pqLRd+VKAJ58hRijYRhprrS6WhqotyXFUc=;
 b=dBgU5kXcR3zoG8rScRNk8vbxuZfusbcO2OPAeP227YtSmKe2Xj6GK9nEeVCo+3mQuU
 eIg6YkhQ1MvRlvMwv9/fxlCOOGALOyfCU6YQpyY9MSrw0yk6UM0dYYBHlhXunPNJ7i6w
 wKnvF/Vs4GI6PjBYylTOfnj3Fpx7MEqouV3zr/98VLBxj9NQwzS8FplV69/hNpqVBlFe
 /9ER9sLO/RjpDgObP/h2fhyhH027VhJ3qii+DCy4+ihJU8U38OWvpdwEz9lTrM1YqO4/
 9e/2V5AGbemzl0A5wzBVp7VWL4iPQEjZzFiFBj01FCpTZLtpbpUQWqG3VzAkxYmfBOC0
 RPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768847075; x=1769451875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tAc/3tRc4pqLRd+VKAJ58hRijYRhprrS6WhqotyXFUc=;
 b=GMDHwm1risFn4VnUS+gPQjq6jHnOsG4ngmpR1IifaXwHUuyvUzjkTwXl0Y2JSayrBV
 7U9EainqTzHVEBx9JfnaWVuIFoR9eaBiPBYyVjMisGVwbE8Ts+QwJ+KD/pu5dWb9rIw8
 g+0IjlMkno/wosQbSZ1WJr+TKibIVOTv0+lokenuzx5jgT7Y9k+EuaqAT9p1Sr8CgFww
 OKr9NYrqzaXGG2dqUP7cR1vE60yYMek8unyaEyAfecH5ZmUUSczK4tIEdwPT2OlZe0yQ
 6qmxGwnLSLOCwYnRs+mBisJpnJnv2EI1SbYmWt32F/xL4jenSAKriqZQPw09jbybXnpc
 FFyw==
X-Gm-Message-State: AOJu0YzdYxHXBpHDQTPC8QWJqFDawZ0liDnkw28cNBHGPgmDMG8yM5Or
 iBQMKRTBIGvnoieXKV2ZlaSAmdOKjlQkIOYnhFTD5HHKit4RInQCW1zAoOWww/lnTcmZ8XIaqEB
 eG7H7
X-Gm-Gg: AY/fxX4/lcdpCwjh3J6/nYkNhyhDtMmq3MhNUiibsrc3EMEHOoyL16Ba1xW5vTsdpVi
 zmDF+HgpckQdficwwUSxZCZuiIMGRpiPiFXQorX7IX9q/hmqYn8fSFL9s5YPiGc36UquhU7pQ/9
 zI7nB+xlV0sgkG8JXBFlzPO6JoDtJtbkLz7xT1aJCnv9rss/n/3nBGlqN1yr91wUXmOTIs05Gm8
 T+mA+zYdAYAx0PoMzyBAo8G4ijiHN3CsleuJrS3DAZEDJR0OD773goBnvyQ/xWjCfIOmGCv/s2U
 VCc3J7eJ5QnB45+A8fdBSfE1XPCIiKzh8XBrJqw7NK5iETfb9JmPWulHYOb2XDLgjIjVIEjBebv
 XB8WlepTDzMIMD5WXETa7qEdBFieG7yOAlB7YA9st0hyuLxzJ4LvbsMejWopGNacLlvyynf5Soz
 3CtXhix1vax8CPM5jXG6azZQCaEzmBUytWrhdCr0/D8F/3x/0IZVGH
X-Received: by 2002:a05:600c:1c13:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-4801e34fab4mr168822525e9.35.1768847074664; 
 Mon, 19 Jan 2026 10:24:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e9ac373sm91156835e9.1.2026.01.19.10.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:24:34 -0800 (PST)
Date: Mon, 19 Jan 2026 10:24:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH 3/6] test: fix race condition in ELF load tests
Message-ID: <20260119102429.270a7e6f@phoenix.local>
In-Reply-To: <20260118201223.323024-4-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 18 Jan 2026 12:09:10 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The BPF ELF tests sporadically fail with EINVAL when loading from
> the temporary file. This is a race condition where the BPF loader
> reads the file before the data is fully flushed to disk.
> 
> Add fsync() before close() in create_temp_bpf_file() to ensure the
> BPF object data is visible on the filesystem before attempting to
> load it.
> 
> Also fix two related issues found during review
> - Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
> - Initialize port variable in test_bpf_elf_rx_load to avoid undefined
>   behavior in cleanup path if null_vdev_setup fails early
> 
> Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index a7d56f8d86..03705075d8 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3311,6 +3311,8 @@ create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
>  
>  	/* Write BPF object data */
>  	written = write(fd, data, size);
> +	if (written == (ssize_t)size)
> +		fsync(fd);

Agree, I don't think fsync is really needed.
This was a bandaid that changed the timing. The root cause of the
test failures was the overlap of parallel tests, so let me drop this bit.
