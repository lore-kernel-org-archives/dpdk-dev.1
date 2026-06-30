Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B19C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C217E4067D;
	Tue, 30 Jun 2026 15:34:13 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 05A9E40678
 for <dev@dpdk.org>; Tue, 30 Jun 2026 15:32:56 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-80f602d8785so24502087b3.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782826375;
 x=1783431175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+N80kLgi2G6VI/O7GQ9mZ/7TcBKVduHH+taXeQ83XOM=;
 b=IcoZro9BZMWh6VOEVm3qtHJRll5azSN9zgJF8PwE0jMDZMCPmIZEcN7twypYvE72xN
 a5kmluRaj+ExG1DSdAHeUS0O8gszSOYIL8S0jexfAFLsPDksZppOfsBt6S/xcgnA61ZZ
 JFw3IFV3n8xSJWsbg7zDr+PGdbo42QulIL3pwWwKSDRM3xZyyxWKAAD8hsaqyRas7NWY
 cCQQ7GZ7BIMKzyX+e2DYFg7TIjsUZX7X7v+8FaqhgKJt6dA6V/0dWGlQjMI7XzXLLO0k
 1OB3JKxEREiM4k4RUccmMI+9i7beKdDOcZG0TRMWyy+sJJd2+hIfG30jx9GpOX8Rby5F
 1Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826375; x=1783431175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+N80kLgi2G6VI/O7GQ9mZ/7TcBKVduHH+taXeQ83XOM=;
 b=X3WsuoUl3teQ5rGUY/XkQFpnMiqVMqjEP1HJs5IFth6qdt12eeSiFYfTcvZvh3FpIP
 dA14MQsBSfGVVa9OyuQ4cxDFuHZP92IRvj+MhXfgta6sLswNQYnVJr6cSgKCWB/UesQG
 691BvPvdiS7OH3X/+UcAsk7yZW3dyw+kceMAgT3rFs3VPMV4OpkZR2GKAD7POwsLcMRT
 fMsIc3rg0HZSksppBLQ+OY2neR4r7uHSsPYwT+OhmeYj85IYAqPyNqgj6TK71AMi3LVh
 iQk0Sch4cksJZBqd/lcb37zwG93wUPFVP5MmYVwl6VqZf31Wby58a0ccqrEk8T8EuoJh
 feWg==
X-Gm-Message-State: AOJu0Yxwj3clgmd0nYvgrGojjvj7+WX2sOWQLwznR7STJv0Dmfaux5wR
 YU3EQr6ccj4gAmxKK/EAdw4RFTlWvpwxLJW2ZkrnD78nHf/g3biu9ujK0iTOtoDJfS4=
X-Gm-Gg: AfdE7cl37C+rlo7YZoMTdNl7v6OVyHDWLhBgkhtUDBKs7JimCvZnPIPzvrN6ltgT+KB
 H/ViB7QcKn6bzhmxgmn91pRs8mVIduHS4E3dW7lwaRADSx9fq79rOYiAv+ISsgrClp02vMnrCLA
 4n49c/K6inecnpEpo0ks+rMNCynfu8H4C4IxZz2oTv73c49iAGU6po/rGe3YDSx//VVbkKV8UH4
 7p7UBy3uPer4SteV1aD96N4ULbyRJ7fYkbNB2bERaBvGjtHIvxz0rrfcjMKqpayEOTL2SEB0uBV
 HXPBQHln2JxGehUs0gzJSbFLAFeS+T8AqaDo3iDhZZ8LudXyEqxD8oZNCepdsFgZ/WGv0WfPGBf
 rkOOnpjXIxhgtWD7OnnxP4Qh8TP0+Pt665qpu9f3NAxRBUHMMT4AE67kAYG560g2Ood9/JifM7J
 y/71FQBCHsmWPnhfHkpmTnvcrtqmNyW5RM0PL4QRYlB2wTDRg7lol+9g==
X-Received: by 2002:a05:690c:6286:b0:80b:dd90:b3d2 with SMTP id
 00721157ae682-810d85def62mr39278437b3.18.1782826375230; 
 Tue, 30 Jun 2026 06:32:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728652esm10700647b3.10.2026.06.30.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:32:52 -0700 (PDT)
Date: Tue, 30 Jun 2026 06:32:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Samyak Jain <samyak.jain@amantyatech.com>
Subject: Re: [PATCH 1/6] ip_frag: tolerate duplicate fragments
Message-ID: <20260630063248.5ca23431@phoenix.local>
In-Reply-To: <de2ff0a594104b9b9cb4575f0ff4f8ed@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-2-stephen@networkplumber.org>
 <de2ff0a594104b9b9cb4575f0ff4f8ed@huawei.com>
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

On Tue, 30 Jun 2026 08:08:46 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > The reassembly code tracked only a running byte total and reserved slots
> > for the first and last fragments, with no check for a fragment
> > duplicating data already received. A single duplicate could destroy a
> > recoverable datagram:
> >  - a duplicate first or last fragment collided with the reserved slot and
> >    sent the whole entry down the error path, freeing every collected
> >    fragment;
> >  - a duplicate intermediate fragment was appended to a new slot, inflating
> >    frag_size past total_size so reassembly never completed.
> > 
> > RFC 791 reassembly tolerates duplicates: a fragment covering bytes
> > already present carries no new information. Check for an exact duplicate
> > (stored fragment with the same offset and length) and drop only that
> > mbuf, before frag_size is updated, leaving the entry's accounting
> > unchanged.
> > 
> > Overlapping fragments with differing bounds are a separate issue
> > addressed in the next patch.
> > 
> > Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
> > Cc: stable@dpdk.org  
> 
> I am not sure it is a bug and needs to be propagated into the stable releases.
> To me it is more like feature improvement.
> BTW, as this and next patch does change the behavior and probably overall
> performance numbers, - it probably worth to add a line in the release notes.
> As another thought - it might be squashed with next patch in the series
> (ip_frag: discard datagrams with overlapping fragments).
> Apart from that:
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

The problem is that duplicate fragments are used to workaround
firewalls. So latent security issue
