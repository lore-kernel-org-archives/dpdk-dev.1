Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A4106F30F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 09:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC3E402F1;
	Thu, 26 Mar 2026 10:15:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CE9A4402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 10:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774516542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Av96+Tb3MjCEKKEs9hrBABdqxRGgXqBX7fUBzC+5Y1c=;
 b=bMG3smmAVxWWYynUgwiXuuxNfbau4sijwDdDbmWokTvcmVmRBkPR1y1hCvI9usYROUOvFK
 um6E8RRZRouZvvOSu7DxKAo4CXssI1nmi8kO2FgUpospbyPHWPKgc/vSU8EuYr9Ksn1ZKw
 XOiY5ZqWa2q0wav/BrGwzCPWJYmj5tM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-t4v6rTpfOxKL4N6JW5hg8g-1; Thu, 26 Mar 2026 05:15:40 -0400
X-MC-Unique: t4v6rTpfOxKL4N6JW5hg8g-1
X-Mimecast-MFC-AGG-ID: t4v6rTpfOxKL4N6JW5hg8g_1774516540
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b8cb800f5so817188f8f.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 02:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774516539; x=1775121339;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Av96+Tb3MjCEKKEs9hrBABdqxRGgXqBX7fUBzC+5Y1c=;
 b=r0cu7fbm63zS/bVlDBx3wHlq7y+GJPHuOQuFTdOSKPJ1TgYk7lwH3BZv4wk/Xv/EVH
 3NcqXCrXxh51H/D5XiBMn9XkskZIC1TY8GC/oPthb7E61QrZ0Trf8PK2v5IDR59PTnpE
 jtjfQbe0SE2roROA3HYh+QZiKiNL1EMmiErg+NjglCwiL0jwdazYZ8f5UdXxgwv7OFgc
 WfCmulpP735US0tWTgc9LRcbxKo3UYFOsqZFT+/9W5PnTEyCJCZGLxZp/5HPfKX+Jo8q
 NILrPZvBmoFhJ9CMSLcaMw+VeuOD1KDVDTE7EokB37yPV0lG+uLcyGrwWSHePNVqwEDp
 9rew==
X-Gm-Message-State: AOJu0YzP2LQzgI+kuIclElukmDFCsIM9CslENY4koLeCt43QZt6Sl/th
 y8G8mWpABIvc+hFf1QcWA8erKFT8+2vVp3e+q1fkRm9UUnBBqmiZ20/NNbjxCGvCFnOzRZWGKI+
 yAuS4cWViXQ+QqsKUmeH1Sn7RazZcDG5FEbNeItlpxef4uQ8oIF96
X-Gm-Gg: ATEYQzyCzkVWeRjD30VfJEz2/oL+PDoqVfxvewsjyVz/eu/TXGmgp/6P6phe43TmbKk
 P8LVp+oW+cB9vPeNRA9WnoULeZ8EyfAyzcgjE+/fH56kI9C3dlwB+T3YrFRwWjZU6+XWroxE3bN
 BKzVGpY/+q69VcoBG29PmjlA9RkWsHMiTV26gg4I6IvKSyhnAV7bRPG6ay8bUeUcVtO4XBMWVG+
 AzvoirjqfjMq9ARsR+rFBWeOjoLN1qCSLL5p4upi6fKkW+gQA6cuEM+D6BVUwFt45UA/1zTobNy
 XoKz5vFksxjjCjeBLyA/R4KO5MJMu7oh5Ge53sFPtUpjBZ531iUvXxVKWA67+xdcyKOJta0xiq3
 M350UqoEOYk1JNvlulUDi7wkFFZsnv/sYlQyQvOl9m1Vvgp/snIcY+AeX2tMXof/fgyNlnWafxb
 y8YZjT
X-Received: by 2002:a5d:64e6:0:b0:43b:4ae5:d7c8 with SMTP id
 ffacd0b85a97d-43b8899530fmr9574052f8f.2.1774516539157; 
 Thu, 26 Mar 2026 02:15:39 -0700 (PDT)
X-Received: by 2002:a5d:64e6:0:b0:43b:4ae5:d7c8 with SMTP id
 ffacd0b85a97d-43b8899530fmr9573907f8f.2.1774516537798; 
 Thu, 26 Mar 2026 02:15:37 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e708asm5949517f8f.36.2026.03.26.02.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 02:15:37 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 26 Mar 2026 10:15:36 +0100
Message-Id: <DHCLM2X3MS7B.3OVNTO4ILW98O@redhat.com>
Subject: Re: [PATCH dpdk v5] net/tap: add software MAC address filtering
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260324190916.422283-2-rjarry@redhat.com>
 <20260325094019.3f4b8b81@phoenix.local>
In-Reply-To: <20260325094019.3f4b8b81@phoenix.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0798yXwZB45UFHZWI2DsIzIuXHXuO25ctVXAmn0LzQE_1774516540
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Stephen Hemminger, Mar 25, 2026 at 17:40:
> On Tue, 24 Mar 2026 20:09:16 +0100
> Robin Jarry <rjarry@redhat.com> wrote:
>
>> Linux TAP devices deliver all packets to userspace regardless of the
>> PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
>> disabled, drop received packets whose destination MAC does not match
>> any configured unicast or multicast address.
>>=20
>> The receive path checks the destination MAC against the device's
>> unicast address table (managed by the ethdev layer), the multicast
>> address list (stored by the driver since the ethdev layer does not keep
>> a copy), and accepts broadcast unconditionally. Promiscuous and
>> all-multicast modes bypass the respective checks.
>>=20
>> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
>> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=3D16) instead of
>> pointing into dev_private, and advertise the new limit in dev_infos_get.
>>=20
>> Add a test to ensure it works as expected.
>>=20
>> Signed-off-by: Robin Jarry <rjarry@redhat.com>
>> ---
>
> Looks good, willing to merge this version.
>
> AI review found some other small things; but these could be addressed lat=
er.
> Warnings 2 and 3 look like just nuisance stuff.

Hey Stephen, thanks for reviewing.

> 1. **Resource leak in `tap_set_mc_addr_list()` on `rte_realloc()` failure=
.**
>    `rte_realloc()` returns NULL on failure but does NOT free the original=
 allocation. The code assigns the result directly back to `pmd->mc_addrs`, =
so when it returns NULL the pointer to the old allocation is lost and leake=
d.

I can send a v6 with this fix.

> 2. **fd leak in `tap_inject_packet()` on error after `socket()`.**
>    If `bind()` or `send()` fails, `TEST_ASSERT` causes an immediate retur=
n without closing `fd`. This is test code so the impact is minor, but the f=
d leaks on every failed assertion after the socket is opened.
>
>    Suggest using a local `goto cleanup` pattern or closing `fd` before ea=
ch `TEST_ASSERT`.

This seems not important for test code.

> 2. **`rte_malloc` used for `mc_addrs` in `tap_set_mc_addr_list()`.** The =
multicast address list is a control-path data structure not accessed by DMA=
 and not shared between processes (it's in `pmd_internals`, which is `dev_p=
rivate`). Standard `malloc`/`realloc`/`free` would be more appropriate per =
DPDK guidelines, and would avoid consuming hugepage memory. If `rte_malloc`=
 is kept, the leak fix above needs to use `rte_free` for cleanup, which it =
already would since the old pointer came from `rte_realloc`.

I don't mind, but it seems pedantic.

> 3. **Broadcast check could be moved before the `mc_addrs` loop.** In `tap=
_mac_filter_match()`, broadcast frames (which are a subset of multicast) tr=
averse the entire `mc_addrs` loop before hitting the `rte_is_broadcast_ethe=
r_addr()` check at the end. Moving the broadcast check before the loop woul=
d avoid unnecessary iterations for a common packet type:

I can change this.

Let me know if you want a respin.

