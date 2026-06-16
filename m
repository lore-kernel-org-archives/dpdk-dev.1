Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A54BCD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 14:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6667E40289;
	Tue, 16 Jun 2026 16:26:53 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 281294026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:26:52 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30b6dad2382so4585211eec.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781620011;
 x=1782224811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY0jJ2DwLaTqAysw7dc5fcQhsCIgww0TuVt0o5c/KWw=;
 b=T+s5vOh/cXcl03O/xXmTYrQHC7p7rER9LS6ppMRD3Jn5nAiNBRqDsQLERQl2X7GpkD
 JzAQ/7sVKTv392pdSRGTqqb/37H846wxHxzby4yo9rM+Nk3Acr11XKoZUVE0Oq6B+lFB
 38fqogOfBO+BmzlCQOCi/WC8GeGENiOmvhdi2udwOFFlkHJI8ExibcIuVmlSjXU3eROn
 lzp6u2iyabwxtJZJjWgGIeymFsJjRhr8vJTc1YwFDIDpn7FwSZPgmtLQM0hKNQc1ACKN
 NrShKDgNrhY2//wx5Sv5MIW+HHRRa5HMW5+wifcbS0eLnr5/qPIMekoT21Zzb+OrQk6v
 NORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620011; x=1782224811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xY0jJ2DwLaTqAysw7dc5fcQhsCIgww0TuVt0o5c/KWw=;
 b=PU4BfunVcULQJASn1T2fEcyIAMNWw9ocnWsmv3KroVju9s6i3tJR+NK2Ho9OqrVLm/
 qaC4XwwJATf0oLLWWGnkefha0hKAVaNPhW6m3/PMUFNtEqtcMEsB7hFeFzLFvx3s8l6K
 i4xGQEMLKDWFRsKVPFIGmFHhugPoGfPalIQGU1CjpqjINrlswWgjniZ5/OC3QE2zSNtp
 KulQlmPLauaoNAOTBURjiupaGIMK4Ee1s4HpJgpMGZvG036KU4jpH1wS0RoGVe6LTA7e
 w3jpTyaJdc/tzkxDseSGVZPe1SY/kxT25DH8ixf27owleuYxuz+ZFFeJShFvXsp4GAav
 iCvA==
X-Gm-Message-State: AOJu0YwPOkdv0I4Wqd4QLL5t0GybnQ6caoUo/Uq0Ye+eu2hMJC9BLf4G
 ugiSwNWUMkiRZECazN3uwhAGWMk+KwAnnkUSDW3DVwz5zyn7jrvCFdHJBSyVi4GM6tw=
X-Gm-Gg: Acq92OHSKhHAJKVCE8zeaFe9fZHbQqpiuIc6a7K7fhOKsMfQ9lrwOKnc/oXuF7GaCDH
 XjmaT7ZVpYwkt591VcOphagVmv1NmrfZ2FPVNED/JUuAfZafxjAL5ErXkqljuBgy+8WThHEMplh
 a3tIxQ+314wMncLZAjwCz7b2KysLEhipgAVkvbyyB4hFtIWGLnHsFHMH+qHSoDcjh8r+Ug9SGWK
 fQ7yTbzahA9+0lfqNosMAHftMP9IOuc7PozRlLuSlS8kCfBmLgKEci3L1YnG2wKyQskMm9Q/QO5
 pXuzFBDjJx3KllmlMc3+kuuacLv/cbkPURlJ2DfScxOBtPvuIC6Be2nLItDKD+zbh7fKmeqp5FZ
 D693vhPid/iOU6j7wHMV2ZblkhBkcBXzFbDbaXEXZRyq/WCSxgZJv0Y8HuBQNBmaHFgp9V3sdGF
 TWQToZZw/AoyZ+lV/50EO20Mv9I7zL1H6L1qAC0AoBhubIuV5BTs2BsT/mad+Co35prQUUn2j8H
 po=
X-Received: by 2002:a05:7300:3b2b:b0:30b:c48b:ad7e with SMTP id
 5a478bee46e88-30bc48bcb60mr468567eec.1.1781620011073; 
 Tue, 16 Jun 2026 07:26:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43f69sm18025117eec.20.2026.06.16.07.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:26:50 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:26:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 1/4] telemetry: allow commands to receive file descriptors
Message-ID: <20260616072647.6cd3f1c2@phoenix.local>
In-Reply-To: <ajFCXCZfikPJTrLH@bricha3-mobl1.ger.corp.intel.com>
References: <20260609210540.768074-1-stephen@networkplumber.org>
 <20260609210540.768074-2-stephen@networkplumber.org>
 <ajFCXCZfikPJTrLH@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 16 Jun 2026 13:32:28 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Jun 09, 2026 at 02:02:02PM -0700, Stephen Hemminger wrote:
> > Add rte_telemetry_register_cmd_fd_arg() to register a command whose
> > callback also receives file descriptors passed by the client as
> > SCM_RIGHTS ancillary data. The callback owns the descriptors and must
> > close them.
> > 
> > This lets a client open a file itself and hand the descriptor to the
> > primary process, so DPDK never opens the path. That avoids path and
> > permission problems and works across container filesystem namespaces.
> > 
> > Existing commands and clients are unaffected. If unsolicited file
> > descriptor is passed, it is closed.
> >   
> 
> This scheme seems reasonable in general. My only concern is whether the
> lack of potential windows support is an issue? For regular telemetry, there
> was always the option of a windows implementation using regular
> TCP/UDP/SCTP sockets bound to localhost. However, AFAIK there is no windows
> implementation of anything that supports file descriptors or handles
> between processes.
> 
> Some other pieces of feedback inline below.
> 
> /Bruce

I have new version (testing) that passes filename as parameter.
That should work without the fd passing.
