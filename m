Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E4C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 13:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3801F4067B;
	Tue,  7 Jul 2026 15:07:38 +0200 (CEST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id 380474025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 15:07:36 +0200 (CEST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c1274802697so435638766b.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 06:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429656; cv=none;
 d=google.com; s=arc-20260327;
 b=QiZ7SlaRhTU5t/zJHKrF3Lkl4T2E/CbOAaWgOMwVcsX/SAlB+YoMJo6wMNvGRbbMNt
 XpuvfngFqvytj2xnTQ3NJ09DGxdpmwGt/SR7bozDS8KcI3nMxe0b8XTkQZj8bQBH+cQO
 Jh2zXyD/dXKD4Xxu+tKn8UFg764WlIokWXbLEa4yKd+BCRSCmCYZriBqx8fbouQUrZ0V
 t0E0/tiPziPzL6+GNrblwuy2DXieJLrkeTAK0Xp+rjcgmvHJG2fI66ftTPnFCOGrtKbp
 LksEJTpDYROoJU4dIllZgLHZB7SVq3dIdkP0gerJzz9bwqCUTTjOwBoeyQ0Huj/EFFTu
 vXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=syWtUioeSGXQAt1IH6ANTLwWEkvuCcW3ccwnhRqgvPg=;
 fh=iz7e5tmB2gfO0gS02bXbVx221CWv6QwnnLEVLyt0tpw=;
 b=ezt55Ql8TiOp/tnY1sSYuVdakb2Jj9Im1Iph1Jk7kuwF3F0jxXMCkIvnZfk/HB2Own
 3WVAC+HzPZLiDTyk6z4Qhg/RSbAkpGnPusDne8nGDUaxuEhkEH066XsajLcPxAe1YRb5
 XJ+vBiPf0mlaH/H2EEnqgFhAH0SqIIY/lGV130sMzNalUHPVmK0oqv35f0OSXj0X2o1O
 FuJZQ83aUq7RADq+8AZHK/0e0TgpMNVnXjrC8aSpXpCQMvgwZ/K/Lwil00V3h1dHgmc5
 ZTwza/WibPKu7n9OW6KZm1GFMKeMVom9ioMgXn0hgqSZLi0e2kYdAg393A+bv9uhBtIS
 3oQw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783429656; x=1784034456; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=syWtUioeSGXQAt1IH6ANTLwWEkvuCcW3ccwnhRqgvPg=;
 b=F8U4xZmp/H+1RZbVaToY9DXCKI17igRi0uUqzJZFrdcwYrp1D/G73buC2MlkhQCUDI
 SxuICdHzX7KOelZDEPF2G9DieqYKoVWgVFF4OvMrI0jzz2SxlK5lFgj7wc/y93fgExZQ
 WxC/X0LNN0g+Tgk7tJ+j1v38S/WDTktb2uzdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429656; x=1784034456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syWtUioeSGXQAt1IH6ANTLwWEkvuCcW3ccwnhRqgvPg=;
 b=K/Ex4yWf05lg3Wukbt6Gfr5ZBTKjSHYIWQO5fupXYcAwS0rDPVAcAQGg2d8s5yUyLl
 1a9/eJ7JafQPk3jiceFurSTqRDy7+mVYHYfABt0NX/8LJdIEMeBNAh77Sakf2X61He8v
 lR9l+HqBMulHOSynW+fxHXeKPEidHntBrCbYd/DNb2/A4iNz1uxN4rvGOM0QKD3hZV+J
 sycWfFp1iAArnPVdqJsJ58WeXGBHBtZjdNB4lC723k2ejEAIauXVuGCXaxHs5fHh3Rml
 FXtlzFqRysLSe0MKVAkiP52z/eUOqDg0vgE6YsBJwndscnNbpaGUrJAp1jCFUp0jBZON
 VH9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLlFDMxASbtS9nACW5IGthkwMgFOakiNCaBHWvZYFb3poDGlxYEl0ZFLs2L5z5A9HIWQw=@dpdk.org
X-Gm-Message-State: AOJu0YziUYlI8euxWneUCbaptiTmUxnMjj3lAHb8ZAsiYSkp2L0C/FHQ
 1wMypz+qe8IS1M/KgigPkpkgEKjrhAo4vxZVSdUiVd+qlaGUfL0tFjncrW6zDur8aPTyCtEu5xQ
 7AGTqX06nRgZuSKiSOM6jyPPJmTDpTlaRz2meaIwZrw==
X-Gm-Gg: AfdE7ck7DEnwTJWga/+WrWKc9sLZbrwpxn1VXEAmCpycEUoN1btv6kShwFwzRzYf9lU
 KT4gnLHjyurxoPqAo0qff6k6kvmyE78MOBYfJ8SHkcIWBVcawIcVYxvsl3fzWfYZ2DHbtpPR8ng
 0Tn1aZS02+9I/coLBEmZB8+maczanWV26Y2fYOt4JclBWj/1a4oYy/HhDww0WYhPi+uVS6bg0q2
 iizRdkJus5RIVl0hYwZ3AQ9zTKkdy5lQB3o50ZwY3eCTeen5ME8xz/P2pC1C447Vge2xNqXeuFG
 qps4CsDB0Vcmj3nF0AXnQPydwovrIA==
X-Received: by 2002:a17:906:495:b0:c12:7d44:3b17 with SMTP id
 a640c23a62f3a-c15a66b412cmr198920966b.4.1783429653132; Tue, 07 Jul 2026
 06:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260508141319.52648-1-abailey@iol.unh.edu>
 <20260511160013.78676-1-abailey@iol.unh.edu>
 <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
In-Reply-To: <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 7 Jul 2026 09:07:21 -0400
X-Gm-Features: AVVi8Cd7E8GZsl44_fmIl52CzDEuHrVPEbmdAbOPLLVj-ZxkPUTGtXKrIVlqpus
Message-ID: <CABJ3N2UPaeLyD7Mv1vtoQSvRJLK0MUfC0LHvvuz-kvjx1YKwcQ@mail.gmail.com>
Subject: Re: [PATCH v4] dts: update test suite names to be clear and consistent
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, lylavoie@iol.unh.edu, 
 knimoji@iol.unh.edu, ahassick@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000f50e3a06560512c3"
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

--000000000000f50e3a06560512c3
Content-Type: text/plain; charset="UTF-8"

Not a problem, I will send a new version shortly

--000000000000f50e3a06560512c3
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Not a problem, I will send a new version shortly</div></div>

--000000000000f50e3a06560512c3--
