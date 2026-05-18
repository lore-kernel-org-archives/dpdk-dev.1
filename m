Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CACD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 03:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2C1F402A7;
	Mon, 18 May 2026 05:14:11 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 25B5B40264
 for <dev@dpdk.org>; Mon, 18 May 2026 05:14:11 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso7656170eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779074050;
 x=1779678850; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zA5rv3c9KP2W1l2aIYDDfVlXv3fXm4GYl0IgnH7zvbA=;
 b=iJ2/YoDOM1jMJi4APGErRMo2WUMogxu1Nhp3mOCktWg8svcy1xr843oSZU9+/OsT3c
 bddu99gweUVL2+VkiHYMFhcbT8T/Pd5v6xA6X+ZVIuVTtxIZXfvIghQJJEZneg9sYCq2
 hB8OjuEgpv9SOkPD75FuHMrAypkp5qL2IBMS2/d/INT/2o81YAsXJEawdLx/dkYETLt0
 V0YAESfRxoo9yGDJqBkgFEb4To3dk9WySJJ5lbXEHzOERteoIt7jiA/WmfAmKziZQ2yV
 TJFY17z/FPI4Q54awossTI5x+EAVgUTvBCnOJso1ZS/zasKfswAwGZRdnZJv5bRPePql
 ucZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779074050; x=1779678850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zA5rv3c9KP2W1l2aIYDDfVlXv3fXm4GYl0IgnH7zvbA=;
 b=W4ebINIo0sKA+EU4lN1CPM4+m5jO3Kq64MOz1Qpu0xd8ZbA/Gn9800eMBY41LN9Ury
 cKyodnzCnPHKWJ8cYdThZ+hZZGoAqESwtn/74WrzRmNItZaZwgU3oQXf8saVZcA6OX2z
 cJwk4tk+XfCNB0CFco9pfQvQ7VQZcKl83J22NXGLDqNDLHl8/Lltg72v4+gDJxQ1srlL
 9DXHitU2T12bEs6+v5a5oMuaW+dERL88gEdFLEzgDhXkuZHmQm6aMBtiwLwzZS3PhvX4
 oWpNb7MOJLZaAQqfwKWqkCYZ0eD0SBq1n7u5ALJsVA0i3KoWHDXjqtyb3NRqC1CSAjr/
 51SQ==
X-Gm-Message-State: AOJu0Yy6lO3WjU2pJ+ObA0I/hxc0NX0PvpUL7MkA+2/ZvoHUqNLOw+QA
 HrYmAYkkBLnq0J2s20mH7qFNjTIj+RigBGRIe9breHGqKN+qCg6bt+S/jhK7HsIjtO0=
X-Gm-Gg: Acq92OG1JMzrAyJxS/ICFoKbzFESdXveKKusDgylYTXIzdofJVnW765fTn0WjaasMI/
 gY4MBY57k0gZA6Syukinqd43Xsozbhg7eGVGqKR1rqnwtUeWWVTWkmr/VhIhs5J+XwgKDhRseIY
 npIdmB5YkJ7jcLiHhTODem6byrYTkM4XVi1vTYMaELWN9y5Ul+1K01+0pskxR3wQbEtbSO0D3r+
 /hyv6D/jB5LlV7E7WoaWOM4j2vSnFRvOYe0a6qLER6fnto5Mi16pyRkmDqXKc9OXTwaJL4w53WC
 X8EVQDZMH4hBm87Uod6bZjjKmr2Rqrhq7a4yCDw+zjZUy3LS+1qjTJYYx+y4322CxjP3RTjwGjz
 W2zlQh4Kc7EFF1jp5rjR1OmySNZ0EulBaF3YK20SZxyrejK90uKnJk0hwkH2BTkaQcyPGxmHiWU
 j4F1NuuTWHtpcXuNwGx0NtNOM7PoBt8zyBz02NDeVfqxyN2g==
X-Received: by 2002:a05:7301:fa0e:b0:2db:2089:460f with SMTP id
 5a478bee46e88-30398626b67mr6084027eec.19.1779074049975; 
 Sun, 17 May 2026 20:14:09 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978afdd3sm13063400eec.29.2026.05.17.20.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 20:14:09 -0700 (PDT)
Date: Sun, 17 May 2026 20:14:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v4] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260517201406.5784dd6f@phoenix.local>
In-Reply-To: <20260512151611.186577-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
 <20260512151611.186577-2-rjarry@redhat.com>
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

On Tue, 12 May 2026 17:16:12 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
> 
> This allows supporting stacked VLAN/QinQ tags and IPv6 extensions.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

AI patch review

Short summary suitable for replying to the patch:
The v4 patch claims to add IPv6 extension header support, but the L4
checksum path is broken for that case. The patch matches both IPV6
and IPV6_EXT in the L3 block and then falls through to
rte_ipv6_udptcp_cksum_verify(), which is documented as not supporting
extension headers. Concretely, that helper uses ipv6_hdr->proto for
the pseudo-header (which is the first extension-header type, not the
L4 protocol) and uses ipv6_hdr->payload_len as the raw-cksum length
(which over-reads past the L4 data by the size of the extensions).
Result: valid TCP/UDP over IPv6+ext packets get tagged
RX_L4_CKSUM_BAD, contradicting the commit message.
Suggested fix: keep IPV6_EXT in the L3 sanity-check block, but skip
L4 verification when l3 == RTE_PTYPE_L3_IPV6_EXT until a helper that
handles extension headers exists.

