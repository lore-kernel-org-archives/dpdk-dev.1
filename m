Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CFF3381D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 09:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA1C5402D1;
	Tue, 17 Mar 2026 10:07:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E6DE440270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 10:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773738447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fe0o/Qj+Ri/GT5M1HZo8zeFHXDx2Xv/qpPKXZ0rZ5CA=;
 b=I2WAbHqMMNcG0xJkQFbUBm1GqK9DE+klUdvUQW/lnaFFyvQNdEtufXOmikttJDk1RQm3RQ
 OsLiMj3Lemo8zA9KWJvCRkmqYc2X4rD9Bf8Uxy37K2YP0pyixJ+jLl33KoUBxNzTY46dtd
 F44dN+aDQt5ny3A77GWZjIkrqCXPqB8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-KTpy-GSeNfeo6v-auFOq2A-1; Tue, 17 Mar 2026 05:07:25 -0400
X-MC-Unique: KTpy-GSeNfeo6v-auFOq2A-1
X-Mimecast-MFC-AGG-ID: KTpy-GSeNfeo6v-auFOq2A_1773738444
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a13072689fso3593803e87.0
 for <dev@dpdk.org>; Tue, 17 Mar 2026 02:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773738444; x=1774343244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe0o/Qj+Ri/GT5M1HZo8zeFHXDx2Xv/qpPKXZ0rZ5CA=;
 b=JDiX6vAHdr/xsSIkYaDzjtxduNwjdBMBfq6Rc4cqWeCuJ/hFov5rwmaWi6d8qWo5y4
 KgKKivNLaBgQdP5h0BidhFTJTLbNW89uxElfvvWyTMiXqVH4bdnYtcIxE1isDVMrY0He
 k6qUYVGch61IOt5C/O75NU5CwcNeot+TYa0/zExTm9afvUycALbwmDEcDxH+87t3wcSr
 UzppCGOWDtFIKRbTcnEMOAV9csZisfwAQCvaiRxKNVHDxKGDiBkiu8k6qWrMFuYm1+3V
 vaV052s7s9LfI/RJtgmkOuHPWMNe8mU4EeNbRS2HiQJGMRG/QPJzpA6XoyKxkMqgQyDA
 rhhg==
X-Gm-Message-State: AOJu0Yx9tCi84B/fvvZ5vze5JlwVW6scbTLL/a3ZhdOuC9oDwsRDw30M
 3FOq9k8KiRb86aQMBD/OkjAQt9vI81OBkfTN6i5KPZNXrEOFj8GUzk6mjFxEVMiiGga0aQHQV41
 1IYQAgnJ7M+Tkk3IZPNwn7CMImMI+jAk93oZ1VezNQS4cgy3Q1vMmXYDjvR6Xic3hd4iGQRlYLl
 B42DXobPyG8+UXWXUTFzc=
X-Gm-Gg: ATEYQzxGNEnnfw9ovtY571+KYvosIpKtTAJe7Q40s89vLGqZuvD2G93gRs9VhxyYXBf
 JyyNW3qMPZ6lGHW0TWRq77KPRMfeF+C9tzREv2GPuizR3BPBI2sHhmdxHapxmwnDWAAtIm6b77W
 JY9QWGMUM0HmM/KuOev5dm/wHi9u9uzQn2XRpB4RjySe8lUZY/jnYLNvoNux5gr4gDkD7Ch9ruY
 NzcRMquJUMouCDJvRIQZdqTawagCroFIwxfTOGIYrOi9S4e+lNu8MzLhOFSVMO0jb9/hQ==
X-Received: by 2002:a05:6512:3b28:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a16280b4eamr5734844e87.19.1773738444005; 
 Tue, 17 Mar 2026 02:07:24 -0700 (PDT)
X-Received: by 2002:a05:6512:3b28:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a16280b4eamr5734824e87.19.1773738443538; Tue, 17 Mar 2026
 02:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260310122045.4057836-1-cfontain@redhat.com>
In-Reply-To: <20260310122045.4057836-1-cfontain@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Mar 2026 10:07:10 +0100
X-Gm-Features: AaiRm537CqIqhnuuwR26i8_P3Ibsga53WjQHeQNLA27Nc-q5uRP7h-RRf22KHTM
Message-ID: <CAJFAV8z0+hKxOxg+ChDQvP1huhkYoJ8+Z90M-8_Mwxkwnj2WLw@mail.gmail.com>
Subject: Re: [PATCH] bpf/arm64: support packet data load instructions
To: Christophe Fontaine <cfontain@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oani6bukBfDU4OP_wXDF6C2DjqryMtcvl_ENv4Dwgfo_1773738444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Mar 2026 at 20:13, Christophe Fontaine <cfontain@redhat.com> wrote:
>
> arm64 jit compiler didn't support reading from a packet.
> Enable arm64 JIT to generate native code for
> (BPF_ABS | <size> | BPF_LD) and (BPF_IND | <size> | BPF_LD)
> instructions.
>
> Compared to the x86_64 HIT, only a "slow path" is implemented,
> '__rte_pktmbuf_read' is systematically called.

Worth mentioning in the commitlog that the unit test was a yes box
(failures to load mbuf data on arm were silently ignored iiuc).

On the code itself, a review from BPF (and ARM?) maintainers is needed.


-- 
David Marchand

