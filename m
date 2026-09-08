Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F7C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55ED0402DF;
	Tue,  8 Sep 2026 16:26:43 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 82A9E4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:26:40 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso39668015ad.3
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788877599;
 x=1789482399; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9f7PhFzQ5/cO+APUQTOQv1RSjXxt1JO3SlH0xYpderA=;
 b=dXyS2UzUS4oWKSIqZ7FbXMd9E5mJKX2BMDRErgTnGvgTBHSV/hCOpO2myl9na4BK2i
 NNe0e2zk53Y8V36FNnGN3mQSBQVd3TQNAL9MZOap3H0F3nH4MvvKIsA8PPYuu4QocAFO
 PopBHsl81jzuu1TjAlZyI8qPiSQJEcPLTgSXH6onyolP4EsM1+34F6WXVGpTP8FmT26N
 zyQYoIM7j0XglDCLgrCPiJ/8Kep80wNXD+5F3eXKzatgitRNhqBnq54BBJmI/Sq15Fsq
 tO0LbrnIOYw2usj8Wpf+FsLF+c0G5YH0oHgyVDVWJZkJ7WHqLXV4AqmhSJ1lhohwzK8Y
 7fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877599; x=1789482399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9f7PhFzQ5/cO+APUQTOQv1RSjXxt1JO3SlH0xYpderA=;
 b=GwRe57mai7/nD4frTA6jGC6ej6B4B0XnUMnV5twDJToDydaSURBFDlJbiQRbr4Oxsq
 MQBe8N7kzQKUkGZuF43a7oMrZ4Smec+qfSqp416Dx5cOXyS3CsSgTK3KvokZbDFfsWNz
 +3HgWZJ/I/cTrdTc8IH5qth7kdzhGB87vXmFcqe18ldxHUJeV+sjRj267GFp7mKsE0u7
 kStOeGvlLvW850Oog6muZqJGfYVDuqWsgZl96vyWkRO81ab6gSu7TXJZTJbtycqtzwqI
 HhwwlZLS294QXo59hrv4z9pwT+rcpqvoFWCurfoq0/0MfzodbdIAXmvLZ/nlt3VRwmfY
 oTUw==
X-Gm-Message-State: AFuF++lb9q/KgEral23zUhNM3LUSPGHzZ7CBMBT7kOq7Qmio7YT0c7y4
 lAqV/fk6MeTP8Z0o+0R0NHH/vH1G5ezBhPIj6kl0GkYEfPdHdt3zdIXFEd1EWFGBMuM=
X-Gm-Gg: AYBFou07TlBRBxXLVeUZhNfh3ocAreAazCJWAX9yiV/aFOc/AQ0uJJSVu/dgBfzRqM3
 5kusReH7GiiuH+eg6USGBU79p1arLhW4fYV5fMPxz6fgZcJBtYK1ipktQTm5sHGgcV5t+5GjV6f
 I358l7L3mrQAtnjvITcNuDeuMJJZ41D6E4TqsUFVD2QSaS6eFo9KcujF//djW36shOo2fKOf2MW
 rz+3+Fb44ksbFbYGZevWnsIicOiUZ9sQLbPY23SZm08yvTSRRDYPUGpx9GeKfMLsOFz5/Qs3bGp
 +Bhr51QgZb0SO53KwcFcMaBZOfX+gSCoDxAlEigggVeOpwiRDA8FOisJG46NnsbRUwknfMZwr7d
 bcgaV0omQTIZVdWXHbO+sGCyrPgzYVmwf0nXveGsbRfuWPC6aeswAjmttzxIBFSxDSRL8fwron+
 EiGYxYNPj2P63Nd6p7G06p/b8WchJFgJ0omhqAs6jCoNSvLr4X8sM8d9r2rEYy4GuSghgYRqN4I
 fXiJixmxrPFPdKNeUJf1KEtQIX9Sw==
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id
 98e67ed59e1d1-39b2614df9dmr45438397a91.2.1788877596619; 
 Tue, 08 Sep 2026 07:26:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcc090sm32559753a91.4.2026.09.08.07.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:26:36 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:23:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 1/2] net/i40e: fix MAC address removal
Message-ID: <20260908072325.1a6fa31e@phoenix.local>
In-Reply-To: <20260908071854.3419531-1-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260908071854.3419531-1-david.marchand@redhat.com>
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

On Tue,  8 Sep 2026 09:18:52 +0200
David Marchand <david.marchand@redhat.com> wrote:

> MAC addresses removal was tied with VMDq pools even when not used.
> So if VMDq is not enabled, no address would be ever removed.
> 
> Fixes: f9ddb36e0065 ("ethdev: skip VMDq pools unless configured")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Applied to next-net
