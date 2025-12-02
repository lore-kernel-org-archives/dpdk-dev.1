Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC17D12689
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 23:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DFC84021F;
	Wed,  3 Dec 2025 00:53:15 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id C72AC400D5
 for <dev@dpdk.org>; Wed,  3 Dec 2025 00:53:13 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ee2014c228so46592461cf.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764719593;
 x=1765324393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJOD9wHqtdr3ZDjUpU4sZHsn5E0o5EhOpjAqTywBsc4=;
 b=yBWUpyHEHAgPzJ+T8nrPAoiHRow0/h+zjrsxad0I6uvH3YzbhoRPHfWuJtGkbXOh5e
 CNqs3PMVhS/XWiQYv6YNsy8dsTXL0whIJymr4i9FPsdASDNcgSjCaVMRGAMoxPV35siv
 Njmrg7O/caVt2jTipBWBIlN0AM951GRdHBtrCPb2vyBGF6TFbx6p0Vml8V8ASxlvPqXl
 eT1KlShWN4pI69M1VUx3BycH1uKdvahRjdwkzd+35TAr6os2PflptrukxtyWjTp8ln7a
 F7N/PHx7dWB9k04uBZeM+VsR1SQwHzuVDm5AelcjoM7Tyd75jYdu+YNb8iSffWkhHnJG
 ux1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764719593; x=1765324393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJOD9wHqtdr3ZDjUpU4sZHsn5E0o5EhOpjAqTywBsc4=;
 b=j/G8I1rZ5+FhKMkp7mqisSkJd9cKSXL56pYZC68Yu6xd8jmQCKicstNZbX5xpPfJS4
 XDWCXhdTBpXq+RxQgTqk9Tq6JF0C2XjClFU6/eolqxohwiNjSwHPsDjrUVp3Ykzu8sk2
 er3yOwEXT6oX6R4qmz55wD+R+VmZsaJ3g1LOOHRIdsrcl72vhXgArd98zSJGfo8fTGIB
 5ti5xmYjoJiVg/AkBXy9+5g4hAsMhtoDdlWDkXS02x4BcZQaGlWMQMGO71GDbcVlCE4r
 CLQAz3whB23UMNZOInFm3YaqhwFUI8Tn5rXkBjUiGtjan3ScUTJ2R8HFzeccIHPGw7TJ
 34hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVllht0NThau7nh87rM0CM0ZI3CpK49DGyptx5duDfD5SMhsi7DYkXKilfKpfSQQLAaBMI=@dpdk.org
X-Gm-Message-State: AOJu0Yx/VSM0ygDrLMVGmWA/1/3TOR+6GfDH7KKC5OFCZr9sKjCHrBM7
 nha1T/3LVNr6cT2hxa606yFFXExN5SBRXWDw1f6o8qA4ArMNkQdhVvgdLm/ra8rzUBA=
X-Gm-Gg: ASbGncs4O6suQfJ4Hx/g9ENsxJ1cxcbkIL1W4hAWqtpqyPkgQxcM6TlkHXmy4AHPf8d
 A1JLT81aNs7gMPcOiSM0gZn9WNbWtNZ6x5sLJ5MLJ8c5px5YBvf42lGqDmDtA7uuHk8IykIt4Ib
 UjIyB6iH4X5CHAV7+3N+R3KJRsC/MKAFs/zn2emzI4yvkmwnOOJ6Ll/ykJ1+rJX4jbG/tsiVO0d
 tAxnKXv6KLtZhLR6LTTcRrUW27euQKjXZlI52mhFMS1/Wj3eCSmAKSpFLOWsZRcky4UNs8b9dqN
 MX6P8RXfzryQhzSanREfeMlIV0kH0Jx2/9sBg8tfTC5he+szITTChasxWD00uETyX6q/gmYyuwm
 Wa+OG8kgPZDJeBpyzYTL5Qs0qwbfszajEdSBR03E/ei1jMneanksTJDJ5JnKY4PfU2dtmqcio3N
 NxgwGAA5T2wkXPRcwH7wsimbi2m0vUXiaqu4B5+k+s04tY07r6qi2630qnaMFW3Io=
X-Google-Smtp-Source: AGHT+IEriBR+VB3A7Qxw6Ur/svje7+4T5taaefVbmHoMYiehI9FWe6WE6N6Pt14q9Q/QT2AYR5xdRQ==
X-Received: by 2002:a05:622a:1489:b0:4ed:a744:adc with SMTP id
 d75a77b69052e-4f01757f2e8mr5531191cf.10.1764719593013; 
 Tue, 02 Dec 2025 15:53:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b8fcb2sm114078916d6.52.2025.12.02.15.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 15:53:12 -0800 (PST)
Date: Tue, 2 Dec 2025 15:53:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: a.schollmeyer@syseleven.de
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: fail on shared rxq switch mismatch
Message-ID: <20251202155254.0d61937d@phoenix.local>
In-Reply-To: <20251201102211.490071-1-a.schollmeyer@syseleven.de>
References: <20251125102207.428661-1-a.schollmeyer@syseleven.de>
 <20251201102211.490071-1-a.schollmeyer@syseleven.de>
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

On Mon,  1 Dec 2025 11:22:11 +0100
a.schollmeyer@syseleven.de wrote:

> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> Shared Rx queues do not work with every combination of ports. Besides
> requiring the corresponding device capability, shared Rx queues also
> require all ports of one share group and queue ID have the same switch
> domain and Rx domain. When these fields do not match, shared Rx queues
> are not properly set up and queue sharing may fail silently. This can
> happen even in some less intuitive cases like multiple VFs of one
> physical NIC and may cause packets not to be read by the application,
> depending on how the data path is implemented.
> 
> To help with debugging issues with shared Rx queue configuration when
> using testpmd, this commit introduces simple checks and error messages
> for members of a share_group and share_qid to fail whenever there is a
> mismatch in the switch and Rx domain.
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---

Queued to next-net for 26.03
