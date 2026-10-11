Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB53CA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C9140279;
	Sun, 11 Oct 2026 21:51:44 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 95EE54026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 21:51:42 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-88c72646f03so521678b3a.2
 for <dev@dpdk.org>; Sun, 11 Oct 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791748301;
 x=1792353101; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cqb8aEPyj5l5xrIHAKyyMkoVXJAtWnek+8wMIu3YYik=;
 b=W2Ay6Jw7Cu5IE+YGR45oD5LsVJ09gAfCmI8l2nY+Ay7T7DPY5v8k+OYK0E1blhb0iQ
 wojAxAyd3C7Zi4Ibapw9XEBtYtxUj0h0qyDrT6pr5fqhzu6Cod95VK8uHqqZ4Y6ZVWjC
 oq9hvCeYpPJO6EtVXuuYamA6VTy3XGAIRAKYsBP97WAIFc6/RDzHq+T5Ql9Z6xOMPcSk
 bmEvNIaSru4560GGvj6thqyTGE71IX+UBjB8g1LH2EiSb80Uw7IfwaD+8sjaysH40acN
 wMeyz6jUSXTBMxOK99g13mtPBE3Wvh3A3URpc9d2oMG02MmiXako0VUk26NY/bQXFJ4k
 SAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791748301; x=1792353101;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqb8aEPyj5l5xrIHAKyyMkoVXJAtWnek+8wMIu3YYik=;
 b=QAFWCs1QvY/Hk74qY3A7izo3LgiMtkUg/SKvfMgalfwXszQYXs1S/7vuM5nV+12ifu
 7CyC527x4R7KKTXbl2E5x9n+Lo3jS+QEwcD2zDZPKUojSPOog6h0P4i6zEqTUaSyi15y
 tkv7Bhf/I8B87nMAG6Q16+jArJAPXG3tsjHKhz8CH+d9md5VxrxPQNRyYcbgZk4ZP9j0
 PN3pW2neXX29pbxKxda+5gUIFdH14B4/POCD4i54ZSE6XyMFH+g7JesFrmStvysKOC8z
 xj0F2+7fpDW4LE35r+pEK0lpHx/lDp9//lRxPppvM1Iy/NQsicVurxcyQQdSYvqLS1XJ
 2T3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgYk6HXxS37nEwAUSx2x0fnRVVw8wCgiBE8EpGd9tv2/PGrbcgSha+f1IeksZN0jUzPY8=@dpdk.org
X-Gm-Message-State: AFq9FYIOBqzdHVipkhJWUcKq7RAQB3GaZJ1jrC917gGiWgvBXdkcjJFa
 7tvDtwH0SVTe4CaYbxS+yHl+N0tdlzZvBcHUJur6NUDrFfCQCKDlGRmmTv83dzKdYN8=
X-Gm-Gg: AYBFou2ZhbI4sws58OahQH3rrb7vycYQ83UP7RyMmOYh13IYpvmzfM3Vgdrw4ZBPgCI
 dYgkrw9aREIh4CQTfbAnJUAJBtiN/+f2QSxQnD8orix2m0TVHii5RYotfVuPDRzeGApqw/DoRUE
 fOJBHQIYXwk0YESnqiOZT34WiMrGQWdwH+Zv0nZ3L73k9et4WHKB7WmL/1FsylAQpPa92r6QZsc
 Yu0gksxoCVt5aT/rXXxKNOYLzya+yZpDmgax85k2ju4zhk/ql4cOtjoYOud9sj1dh8X2Q12Ddsp
 CRJfezHoIvXTHjGhDff/b/BPQ8PzVcclzF/GQWOPsckvbCPM0dCL4B7dnn+sdlr59MBWaEJSXMZ
 pU8ydLhc++pbCnPNhyF7vEL/CoKfOKG/CKVe3eIEmjKKxnoZX712eZBUuhP1+Kzs52rtd1r3LzO
 a/YJ9KROm5COFtdx9/+xvx/5ENgW4vZ1OmxOtUfwEEQrL8vf9+8aWbstmVBnsN6baABwsENodYg
 QJ/M+rVZSpFUgdeDwRoP2LdKZzd2Q/M0rem2gl0
X-Received: by 2002:a05:6a21:8203:b0:3dd:a195:fa10 with SMTP id
 adf61e73a8af0-3e16bebc054mr8339462637.53.1791748301555; 
 Sun, 11 Oct 2026 12:51:41 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9d492d7sm3430981a12.4.2026.10.11.12.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 12:51:40 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:51:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH 6/9] bpf: simplify callback inuse tracking to boolean flag
Message-ID: <20261011125138.75606f1c@phoenix.local>
In-Reply-To: <20261011182158.124246-7-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-7-qm2k21@gmail.com>
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

On Sun, 11 Oct 2026 18:21:54 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -36,12 +36,12 @@
>   * 2. Member `cb` of struct `bpf_eth_cbi`;
>   * 3. Member `use` of struct `bpf_eth_cbi`;
>   *
> - * BPF program is only executed if the first two are set, and increments `use` at the start and
> - * end of the callback execution so that in the safe state its value is even.
> + * BPF program is only executed if the first two are set, and sets `use` to 1 at the start and
> + * to 0 at the end of the callback execution.
>   * This relies on only one thread calling the per-port/queue callback at a time.
>   *
>   * Unload processing starts with clearing the first two entities,
> - * then waits for `use` to become even before destroying the BPF program.
> + * then waits for `use` to become 0 before destroying the BPF program.
>   * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
>   *
>   * Typical sequence of synchronization actions between CP and DP on unload is shown below:
> @@ -52,7 +52,7 @@
>   *     |                      |               |              |              |                |
>   *     |                      |<---------------------- fetch callback -----------------------|
>   *     |                      |               |              |              |                |
> - *     |                      |               |<------------- increment to odd --------------|
> + *     |                      |               |<------------- store 1 -----------------------|
>   *     |                      |               |              |              |                |
>   *     |-- remove callback -->|               |              |              |       rte_smp_mb()
>   *     |                      |               |              |              |                |
> @@ -62,17 +62,17 @@
>   *     |                      |               |              |              |                |
>   *   rte_smp_mb()             |               |              |              |                |
>   *     |                      |               |              |              |                |
> - *     +-if use is odd        |               |              |              | if cb not NULL-+
> + *     +-while use is 1       |               |              |              | if cb not NULL-+
>   *     | |                    |               |              |              |              | |
> - *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
> + *     | +------------ fetch 1 -------------->|              |              |<-- execute --+ |
>   *     | |                    |               |              |              |  BPF program | |
> - *     | +-while use is same  |               |              |              |              +-+
> - *     | | |                  |               |              |              |                |
> - *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
> - *     | | |                  |               |              |              |                |
> - *     +-+-+                  |               |<------------- increment to even -------------|
> + *     | |                    |               |              |              |              +-+
> + *     | |                    |               |              |              |                |
> + *     | |                    |               |              |              |      rte_smp_rmb()
> + *     | |                    |               |              |              |                |
> + *     +-+                    |               |<------------- store 0 -----------------------|
>   *     |                      |               |              |              |                |
> - *     |------------- fetch even ------------>|              |              |                |
> + *     |------------- fetch 0 --------------->|              |              |                |
>   *     |                      |               |              |              |                |
>   *     |----------------- destroy BPF program and cleanup ----------------->|                |
>   *     |                      |               |              |              |                |
> @@ -87,7 +87,7 @@
>   */
>  struct __rte_cache_aligned bpf_eth_cbi {
>  	/* used by both data & control path */
> -	RTE_ATOMIC(uint32_t) use;    /*usage counter */
> +	RTE_ATOMIC(uint32_t) use;    /* usage flag: 1 when in use, 0 otherwise */

If it is only on/off now make it a bool.
