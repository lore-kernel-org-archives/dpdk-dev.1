Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF716FD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE0040279;
	Wed, 25 Feb 2026 23:51:11 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 295F7400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:51:09 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-127380532eeso517900c88.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772059869;
 x=1772664669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2/h96sAXYL/fLIHmlSUl1ywzWcasDSsy4pcGjyUtrk=;
 b=MePqiEnO6ZCIrjoykq7EoJj1GxDeZz8Uz4cXM9fH7WVaN92NVlTK4Z60/M8R9znPf3
 YtdXBC/22ZZKjTetDSYsWmoDkSx2Dbw8YUXmCJ/aQDoQaF7Xr03ODgXRGarW2HOdOQqA
 iPwcxlpfBeuiKwHYKcRlAZLBBUGJvzYOTFvIDt842UignDrzk8QFMyB/WwFn7xyT62/l
 BpJ4QrQxvekZd9QC/6y2kTaBQxrRxex2guC6JX7eYbZvJzPmWJnrsrWSBe5fiTfd25jy
 kUFJJ+FlOFkNrWWzNBn0EYSs+furv9wYoQX5jGXeUEI1D5JVTtYeZI4LliF2AMs4gpcT
 F6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059869; x=1772664669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2/h96sAXYL/fLIHmlSUl1ywzWcasDSsy4pcGjyUtrk=;
 b=MgTIBt6q7+w/wibL9kOD2AZ4IUDdudqquJVoBYvHdMlB/chQxP4mFzGfyoFQTS+ycI
 aE+Txbf8YROjsmo/ak3Iugwm12IJD/bvuY0L7QOr0s5+H9dWPERo6ukZSYgAGYAovxPq
 3TDtcSKxEenpLWkps+X5mTMJc0fkS+XmAyLGT4Y0VS+GcJfXsR+dIM9iVBSh+zdbJOCR
 hFDvL2RVLYqtcrc9OzIqnh2wRv7AWxyPlQPJyPESEtcf0EJloe2/Qi7mZ5+pmVM72dI1
 AGF9Sxo6m5truvJdUuLGfbZKfJ7jQZ4rLVew2CMc7QU1zokJ5bgv5lJZflJctTVMTWTc
 9PxQ==
X-Gm-Message-State: AOJu0YxizSPX6om7onCWhic8Yz5VNwAH1wpD74lI8FXsIUlO0GI5Ddvu
 ad3M1QgWnlRuJhBosIgOxlMxPMxjlf6BXvfOV8LYEJwRrmiZ7ztbAGqvzZUz3LqF2PU=
X-Gm-Gg: ATEYQzwcfcYRzGyQ3AzxjQFqYy36gpikCC3OcEJ7lv3hp7ZnxnrbfYIyZRlwerXVRoW
 vFQoAKb6yR5JJxnizDyZgQneSKgSei6IoOaky6Os2UEQBJnR9OncA4cXqgKGMQ9uwInCY1C6Fz/
 OWmfNlMKG4lOK3WGBd6N8CQj+/F8VIw8B9CkNHy3DNakCu33aZ+oaTESOxbcmHH56XsilW0BHHg
 XouiZPLqokB9NCr4BQMm3MHTm/EdhYChG7f8aTLpxaz7Lgwv4cjsjsY/be/LMqArpmVQ5cuCFE2
 FZOjKp8+gm27UDc8+Jmkx5gbqQn8r5xnkK+Mw/pIQeeS3x+yq5lkRab8pQZ489Rw8SzvwDpoHo0
 GjBn1RuF7K2kT8KovPgiWSkYQGoQvelWgSn7Gn5Nssg66go5zogCB8m2ZEZ8lg2rXJYOOedkLse
 ELtWmeJ1OXPVnbl5XywpPm29YbA2j5xVjr1frSvx7JGFrs4MrEPTCMmNRwZw4kFu9e
X-Received: by 2002:a05:7022:a9f:b0:127:5cda:fb7d with SMTP id
 a92af1059eb24-12789c5fc8amr134510c88.6.1772059869009; 
 Wed, 25 Feb 2026 14:51:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899dfc47sm324661c88.6.2026.02.25.14.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:08 -0800 (PST)
Date: Wed, 25 Feb 2026 14:51:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, ktraynor@redhat.com
Subject: Re: [PATCH] net/tap: defer qdisc initialisation for rte_flow
Message-ID: <20260225145106.571bcbd9@phoenix.local>
In-Reply-To: <20260224152744.3860285-1-david.marchand@redhat.com>
References: <20260224152744.3860285-1-david.marchand@redhat.com>
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

On Tue, 24 Feb 2026 16:27:44 +0100
David Marchand <david.marchand@redhat.com> wrote:

> qdisc setup is required when using a remote_iface or when creating
> rte_flow rules.
> Otherwise, many applications don't care about it.
> 
> Let's postpone the qdisc init to when it is really needed, that will
> avoid spewing ERR logs for nothing.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Helpful change. Applied to next-net
