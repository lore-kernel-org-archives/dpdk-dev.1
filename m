Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC624DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 21:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C8F4066C;
	Thu,  3 Sep 2026 23:27:04 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8BE2640144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 23:27:03 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d6efd73032so13242505ad.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788470822;
 x=1789075622; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0LT8SNUKA0ZcjB0a8GxLqS33rw64y4wuOYJtEVlvmtM=;
 b=EYc9Eo8/DWV3/xUmBp88uSzXRQUZa3eJEy1zYNaPhQXsmgYkFnEjzPYfc6Q6ySJAxz
 DXTfLKMnZtFYtfwnIH1xbcFsAXPaQpXJi5VWzFDRdhTlWQXeJLOCHBzCetX3rouE+dvw
 7FSIVHQWf1c7VgUG0lSRg+TiJCmoElL08tk/ZYQAoSFQaIgXcyw1Tg8fwXIx9sGEzX/q
 doFS+8C9bxFakKVZhWUT50/NtgZodhMmOf9F0sxBueCY3TUWd2xejcDBp5FEdWUo4Vqh
 R/8wIlWnJV61/ws+NYOPZurn3vJStaQwPITPWHhXlnoyWDwTvi17gfDqEu+HxvdKo9a3
 +06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788470822; x=1789075622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0LT8SNUKA0ZcjB0a8GxLqS33rw64y4wuOYJtEVlvmtM=;
 b=Pc5Cfyrqio87bCIOyLpUx8y2w6RpEiUyl4ykYsByfowfKHm7QWQxUwCCa7cBy1aCWb
 /eUS2FRm74xlDcjhh9wVdUGjNcqQSVk+fCwZcyEIsvBDcca+WdCf5TZA2ZexySdIZBPK
 HP95LEgEhLXG+wyKQa2DsMBuBA+uwAWo9j107er9xxE8DIGoVwR5BWloyx36T6MSk9+y
 J2fm3jdz+eEp8fRiE9wGFOVN5yk8Uw7ymosTcSyB7RCU81aKo9oogGQFb9tnWmONJkyn
 b6808I+CwaKySnRbsAaPc/QkmYvcNYjMg/6zgR7aCXoTZ59/HbZmSBWJcCzxHix1JtFY
 rlag==
X-Gm-Message-State: AFuF++l9ZJdvrqw70CC2wfXbSYRUGDlglOD5zPu4q7x9uJvzuxpQjGa8
 9NIpa+cuZu4uqwxb+R/RNv0hEAHpjayLEjKhgZ9hMUQLhhTbfOUsFjEpqZ52FISiGos=
X-Gm-Gg: AYBFou1INUmgJ9WewUROUu5xF6ZL3YXD5rKJb2lEWTCKC7tvvKpBquMgIDhCQ5ak2MP
 d6eUFM6RqihugBHgggm8sLRYl98vV6nwYtGigirhvqViU45IyRm89T1IF/OOVza6CHs3m/VQCtU
 5wiuOLhvkmvEssPcSSBHeEUGy9KPwAVVhSy89WUGvI7Gi2KGx0ZzgY0BcsgHWYNMCrr0mRC7ewX
 ETeYPLf8f5FiO7uBKtjs/7fz9zh8Q+dGN5NJylV6Ccw/BlHv9CbN1kGvWzylBmicoN4mOLjIro+
 YUzGcL3cZpbmoVDnnrMD+n8h72MVFA3SN2ItZssNIv9kyyj7oCi++AfC2D2YXN1RQZ1FD/fRQlZ
 Vy+98PFoAdqKLrKIVI1ANLFM0HCS9+X/yXQ6hoRNJu3+2yHmlfnQURriygMbN5uTp6MLh12QtQM
 Iy1kicxuDFEH0oR/umZuq+oyNfEVWbBUx7a25Y8Dd4+H7ks5Td8xyuaHRtNbv/RWnzgh91TkAMb
 IUm/SICjRCEUcgbtDn1zayDVO9IrQ==
X-Received: by 2002:a17:90b:2249:b0:396:d28e:b53 with SMTP id
 98e67ed59e1d1-39b0865350amr9683811a91.20.1788470822230; 
 Thu, 03 Sep 2026 14:27:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08ce4221sm8600147a91.14.2026.09.03.14.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:27:02 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:26:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, david.marchand@redhat.com, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH 1/1] test/memcpy: reduce duration
Message-ID: <20260903142651.156703c9@phoenix.local>
In-Reply-To: <20251031114310.4062899-1-thomas@monjalon.net>
References: <20251031114310.4062899-1-thomas@monjalon.net>
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

On Fri, 31 Oct 2025 12:43:09 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> When running on limited platforms like GitHub Actions,
> the functional unit test "memcpy_autotest"
> may hit a timeout, especially when running with UBSan.
> 
> This change skips testing some alignment offsets (from 0 to 31).
> It will test only every 3-byte offsets for the source buffer,
> and every 2-byte offsets for the destination buffer.
> So it is supposed to be 6x faster with a reasonably smaller coverage.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  app/test/test_memcpy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c
> index 802dc4631b..ea9e76e9ad 100644
> --- a/app/test/test_memcpy.c
> +++ b/app/test/test_memcpy.c
> @@ -105,8 +105,8 @@ func_test(void)
>  	unsigned int off_src, off_dst, i;
>  	int ret;
>  
> -	for (off_src = 0; off_src < ALIGNMENT_UNIT; off_src++) {
> -		for (off_dst = 0; off_dst < ALIGNMENT_UNIT; off_dst++) {
> +	for (off_src = 0; off_src < ALIGNMENT_UNIT; off_src += 3) {
> +		for (off_dst = 0; off_dst < ALIGNMENT_UNIT; off_dst += 2) {
>  			for (i = 0; i < RTE_DIM(buf_sizes); i++) {
>  				ret = test_single_memcpy(off_src, off_dst,
>  				                         buf_sizes[i]);

This was fixed by later patch.

commit bc15681021d5588072f0635ccb9937d127c64b3d
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu Feb 26 08:48:43 2026 -0800

    test/memcpy: reduce alignment offset coverage
    
    The memcpy test sweeps all 32x32 src/dst alignment offset pairs which
    causes it to timeout on slow emulated 32-bit build environments [1].
    
    Replace with a curated set of 7 offsets {0, 1, 7, 15, 16, 17, 31}
    that cover the interesting alignment boundaries. This reduces the
    iterations from 38912 to 1862 while covering the same code paths.
    
    [1] https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/Debian_Testing/i586
    
    Reported-by: Luca Boccassi <bluca@debian.org>
    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
