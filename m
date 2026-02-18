Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32DFE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A7440269;
	Wed, 18 Feb 2026 18:21:16 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 6901D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:21:15 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8947e17968eso545646d6.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771435274;
 x=1772040074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MiRTxBE8SLHrPi+WLlQJhSspOumLerk/s0exBJ6vZw=;
 b=NmCFJvXxL0aFBjDUdLtiIrt/kf4rpFDHZa0kXI5Qojs2T7BC6zEIW7Q3LxD6Kfbykb
 niLph1rzPDnJ7rHb4rK90na7Cmos+bp7N8NCO8rZAaFEEjeAWSSxNulcJuKhoreI8REO
 4EWfx9ZVRMsEp3fbRi+jSl3nIGrLXir34ZGvBhuto2DVaIVaky6Y8l94M9Hf0NHiKsqk
 bRNDWeTJSDI26CcMufoBCtMOALBZpoFEW0UbasqW+OtRmdhwt7OyTBzforlYUeiULIZJ
 +TyRjqe/6tKBJgWln7j9DAODSLX824ALZCuQ2/hMVWyEMDAAI3g2Tw9FvRL56ZERsiBG
 bkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771435274; x=1772040074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MiRTxBE8SLHrPi+WLlQJhSspOumLerk/s0exBJ6vZw=;
 b=IvhrA4OPhG1OG1JL/9VZ622WidEpL/3QfLlLSRDj4pwccTkeWNFlbF2CbzLu5wvo75
 31/MWfREQ8wAVZElcArE910d4dh55ZdbaLZ0C77BlSL+y86Bz4mRMnYUPTxVM/xdLrKv
 vJz0QUM4jrjxjEELOZNOCtKkp2L6QdOylSDabx0g/kLzZGUI/RTD9sg5TfyK6Tj9LhNA
 F02bGtDra/umzsl7v7OxpOkbUo8CJUPdAKlDTcYWTdKgrZdGyOna8ecStNiSPFYRaNRy
 TX0al/AqIT14/WzUofnSB5ZWEmsiqpUom5zE3iQJ9L3UF5u9QM0Qja1EmuaOYXkFmjD0
 NM1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXgELP08Y+TJHoo3IVfNWb0iVTWQiE1fSOCDMQje+NaQrPAK/29+xMyzO0zQwX6stJfqg=@dpdk.org
X-Gm-Message-State: AOJu0YxZgXlXRhKE+e2KROEn0/K99o/B0pcWSyJ0PakyAR2N4tbSJayO
 zuOdMCYp7EVeynqy6eZSVlgbZ4iM8wVbGwKoNNLKHuTDU1kCkhF1RoEFefVlD7E4i94=
X-Gm-Gg: AZuq6aJDMEWq15oIHyAfXXyDuUpOidtgA372DVzSYe8RI3iUlWHZ+8sIZWcm0VG7+w8
 gvnS5Y4zw6hvaWkW9aCTbiXoNlwxd+SG7vjNlhvGNmZ/jYPMG05WT4ElQUcL8Xqv+tmVWWvLfD0
 6GlUQKKSa/Ro98u3fqVZjKls6TfRQDHO3N+gHswcXvtzgQHwIZYS3rLn9ev3NLckAfKsmEFgsaE
 MXf3oW9sDvDVatozCMoU9wU9Mxy+xE4SSBHRpTXQMFibHBMGkNoBkoGW4AIg7QNWmE5AoW+mJWA
 oE7jkGc+dS5SEKahMhtSFknMn8pdf6H/8SIP89+1N6c4zbIeRo/00Gd4NcMJZ6qy8ia2uB3CeVw
 CUdlSxyUk+P3DrnVjSwSf6OvRi08dkCHwOXH6zbIhH4O9YrsDNfZZihXq3IziuPgyKjm4hWHsKu
 bU+SGd+8oF2YH+Bkshzx90iVbVEsxLQnxOq1V+GzYrdU7bE3qZSWVTGuxoyD58lUWZ
X-Received: by 2002:ac8:5d0a:0:b0:4f1:b742:35c2 with SMTP id
 d75a77b69052e-506a683233cmr212265501cf.22.1771435274413; 
 Wed, 18 Feb 2026 09:21:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bd4b95sm186374821cf.33.2026.02.18.09.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 09:21:13 -0800 (PST)
Date: Wed, 18 Feb 2026 09:21:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
Subject: Re: [PATCH 00/11] net/dpaa2: fixes and improvements
Message-ID: <20260218092111.695aaf00@phoenix.local>
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Feb 2026 17:04:42 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
>=20
> Patches 1-2, 4-5 fix resource leaks on port close and in error paths.
>=20
> Patch 3 fixes a misleading Rx descriptor limit warning.
>=20
> Patches 6-7 replace getenv-based configuration with proper devargs
> for taildrop and data stashing options. There are still 8 remaining getenv
> calls in the driver that should be converted to devargs.
> Note: the taildrop disable path has never been reachable until now
> and is untested. NXP maintainers should validate this feature.
>=20
> Patch 8 fixes link status not updating after port stop/start when
> link state change interrupts are enabled.
> Patch 9 is a minor cleanup in the same area.
>=20
> Patches 10-11 fix devargs propagation on DPNI hotplug.

I decided to ask AI "what remaining bugs are still found by review
after applying these patches"

# dpaa2: remaining issues after Leroy series (v26.03-rc1)

The Leroy 11-patch series covers the resource leak and softparser
cleanup bugs well.  The items below are what is left.

---

## 1. NULL deref and packet leak in dump_err_pkts()  (dpaa2_rxtx.c ~729-746)

Three related problems in the same function:

(a) `mbuf` is NULL-checked on line 729 (`if (mbuf)`) but the very next
    statement dereferences `mbuf->nb_segs` unconditionally =E2=80=94 crashes
    when mbuf is NULL.

(b) In the multi-segment path the while-loop walks `mbuf` to NULL, then
    `rte_pktmbuf_free(mbuf)` frees NULL =E2=80=94 no-op =E2=80=94 so the pa=
cket is
    never freed.

(c) `sprintf(title, "Payload seg[%d]", i)` writes into a 32-byte stack
    buffer with no bounds check.

Suggested fix: save the head pointer before iterating, move the hexdump
and free inside the NULL guard, and switch to `snprintf`.

## 2. Unbounded SG chain walk in eth_sg_fd_to_mbuf()  (dpaa2_rxtx.c:334)

```c
while (!DPAA2_SG_IS_FINAL(sge)) {
    sge =3D &sgt[i++];
    ...
}
```

No upper bound on `i`.  If hardware or corrupt DMA data fails to set
the FINAL bit, this walks past the end of the SGT buffer.  Adding
`&& i < DPAA2_MAX_SGS` to the loop condition is the minimal fix.

## 3. MAC stats path can deref NULL DMA pointers  (dpaa2_ethdev.c ~2005-202=
4)

`dpaa2_dev_mac_setup_stats()` is void-returning and can fail silently
(malloc or IOVA mapping failure), setting both DMA pointers to NULL.
The caller in `dpaa2_dev_xstats_get()` does not check and proceeds to
pass zero IOVAs to firmware and dereference `cnt_values_dma_mem`.
Either make the setup function return an error code or add a NULL guard
before use.

## 4. sw_td label in dpaa2_dev_tx() may double-free  (dpaa2_rxtx.c ~1516-15=
23)

At the `sw_td:` label, `bufs` has already been advanced past the
prepared frames and `num_tx` counts packets already handed to HW.
The loop frees `num_tx` packets via `*bufs++`, which are the same
buffers HW will also release =E2=80=94 potential double-free.  Needs someone
with the HW context to verify the intended semantics.

## 5. dpaa2_dev_loopback_rx() always returns 0  (dpaa2_rxtx.c:2144)

The function updates internal counters correctly but unconditionally
returns 0, so the framework never sees received traffic.  Should
probably return `num_rx`.

## 6. Burst mode info reports only the first matching offload  (dpaa2_ethde=
v.c ~464-506)

Both `dpaa2_dev_rx_burst_mode_get()` and the TX variant break out of
the offload loop after the first match.  When multiple offloads are
enabled only the first is shown in `mode->info`.  The loop should
concatenate all matching strings.
