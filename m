Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B89606A31B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LZo6/vSM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 526094025F;
	Sun, 25 Oct 2026 18:23:40 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 6455440150
 for <dev@dpdk.org>; Sun, 25 Oct 2026 18:23:38 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cd8ba7c2694so640774a12.1
 for <dev@dpdk.org>; Sun, 25 Oct 2026 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792949016;
 x=1793553816; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Up4WfzmFdXMoOIIyU9zwJfiX4v0aKaLy8mXXRXjDYbE=;
 b=LZo6/vSMcfwETaGrssPcyhInJpQGVBODC/gvU6Prl4MvCTy9nQ5qGW6IJA9S2g2SMT
 ZFijNBzls34is3jaodfk65fuiDLzLQWusG2AMJmxQ3Q9NJjna6gOakz0lM2U96ABi92F
 5PBTOHmpO+dVPABwoWn+ulZNYXzWlVEjx5dRcQbcFAGYrMARjonImqinAeEKNLCBIhT5
 l/U2uUXcafbnvN2N9cNFShH4AtZOBAr+kaO6vrv9MkLZDR0ytNYtNMMTyB63XAztzUCt
 9N4jeUTyoPDceX9JSKfP5cDCJfzkFQHwgYZkDfm00bhycPiwkM5ca8IOe463C6G8jhcx
 FkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949016; x=1793553816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Up4WfzmFdXMoOIIyU9zwJfiX4v0aKaLy8mXXRXjDYbE=;
 b=Cs0H8KJsff8GFbDb0QLm4nlQFM2m+Ma7foAlIQHSqvAs5SL94ExHfMTIQVVbgNE99b
 /ZEmwaZ6xKhHV8QBiWtSG5VN9KwMjkkS4DHYUIvNbLal1b7TxHWOr2qy8P6s0lE5Ydpa
 TxOlngoM+UqkQNcJgxJ7OsbDrgrNgxnEcozjHo71kBxqEnydG3iYHEwam5LRwLbAZcLV
 SeNVYU5TO3+/D0AO3I/fy3mXc1EELWbgd8J+BwbGLz1K2iR31fTiU6zVIYPATmnk1JKd
 qHLRNU685XdSZUI+LVFvUVM28SPpZPd+LCv30hEycvzcYVgLoQgW3YGwfKXUlWoAkeq8
 rxWQ==
X-Gm-Message-State: AFq9FYK29Bss9TYteAZN8gLiuyxOyUiF9ujcO51hk/sgLgFDs5IJgqPc
 TAP3QPabyUml5JQy0mWfBRAiV4qmg5bbHW3YR5Skmy9hXks05ipaggSq8Bi6BCLqGC/gDbL3fk1
 P6UFb
X-Gm-Gg: AYBFou1zYC+Xc/hNBnpw3Cy/IOrx+FbMj1L/wThCFBJVYSH7+5ircmzW3doBAhoDQdE
 dQH5a3sEbjApHZ4JaxoSjw2kFRUjn3746bT7bzcVo2Qky6dufF05Y4zcvUaQ2Jz6nBHd64qAaTz
 euDNDI+9ErSSpe1jgSvmeElpv4zEZi2bjWlXnA27KHRkJiof07a4549vbVcxkoBNA6fehWFVJaU
 9QeGjfe/G5LMkl90Di3Nr/pHyq0NqomVAQhtbBixJKMrGzyDk5bbUeOLgmbZYhBN4oCyz2NnIW2
 RDTBctzmwTt/AXPlouDdHUNoYy7Pz2DI0WUN7DzJV5PqIRtkL2sRu3DebNBzuu6zfV44Sou/uLF
 PYma6IekL7HB9ZDkYtuv4o7sVYZ8LQChPaMAK+ax+gzKMCGPTylgWavPxRoMg2a6ZIQjyldmjSW
 +3zIAwzpfLJrm1pQ9Y7CitT9whu0SYdi4eDopv1RlQ92pVck5ARAque8cCRSzEUhMYeX6KseXYx
 G9xKIzEO9OkKABxjktJJbzgz8ohfzwmyto/9Kvos00WymdvqknWaB37wBYbPxM2YzVS67va37Th
 Oo/3kAbQEskjnKcSrYM0c78=
X-Received: by 2002:a17:90b:534b:b0:3aa:fc22:8aac with SMTP id
 98e67ed59e1d1-3adeae5dcdbmr4252445a91.51.1792949016486; 
 Sun, 25 Oct 2026 10:23:36 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe6946dsm5332428a91.4.2026.10.25.10.23.35
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:23:35 -0700 (PDT)
Date: Sun, 25 Oct 2026 10:23:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v5 0/4] wireshark extcap support
Message-ID: <20261025102333.3ef59446@phoenix.local>
In-Reply-To: <20261016223201.608942-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261016223201.608942-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 15:30:30 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This series adds live packet capture from a running DPDK application
> over the telemetry socket which is usable as a source of Wireshark
> external capture (https://www.wireshark.org/docs/man-pages/extcap.html)
> 
> Capture is avaliable by default but can be disabled on the command
> line with --no-capture. It works on Linux and FreeBSD.
> 
> How it works:
>  - The capture library registers telemetry commands (/ethdev/capture/*)
>  - Callbacks are installed on the specified port/queues to copy packets
>  - Packets are formatted as pcapng and written to the specified output
>  - No packet data passes through the telemetry socket itself


I am going to suggest deferring this to 27.03.
Not happy with the security model, and using telemetry as the control
channel. It needs to have its own control channel, and the destination
file needs to come from the helper not get opened by DPDK process (primary).

