Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252ACC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 17:31:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04060402D8;
	Tue,  8 Sep 2026 19:31:13 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 58F4D4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:31:11 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-86309e1a213so1104246b3a.0
 for <dev@dpdk.org>; Tue, 08 Sep 2026 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788888670;
 x=1789493470; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nB0XFhIh0bRaFtSeGOZwBhInW7MfLTpl9eN8xyu8J4s=;
 b=pW2ZZR6odVaEm7fRtP+0iztP2SeD5U3uAtsbrkubaqLitCrJIsCik4RQp7PV1O9Ih6
 C+8a/eAMNON7Mxhx4A6wKEOldUGtsKx+Jm+hYymj87uyNaFah41pfsR55A4/uHTyID7L
 eKlgDNY1XczHPwESTEeoLuJairGegGMzpIudCtX5orTsg3ilocYlJAPeKQ7LCUWSJ6zQ
 EogLfLHzX6o1EKaNfAgTjcrqePqBx3l6CcZpv9P/9xKReNKbB3HW5fF6WYMb2n1KvmCl
 a8owV05d7LxUhC4vGcDk/LzjRhjXZV8jTfz8r2NLwjhbGp7UrrIY6XtLy3uwNLDK1JHf
 eACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788888670; x=1789493470;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nB0XFhIh0bRaFtSeGOZwBhInW7MfLTpl9eN8xyu8J4s=;
 b=qUGfGU4PDh4oRpuR5J02138srQH1GOy1sPs9Uc34J2RBT+S9er+HM7DM2sx8v5Yxxy
 UUfKaAs5LOYdpDfkC+1SNE/Mgyu++lP80JPQN+1RDFkYLYpjhOd1n8kwKBmJb+0p5965
 YCVjVYQ5nMOrrKUROkf8vqTcl4uAPWpX2jKqrvtvlPVHqePPJTY7/dUk7DQCHBYv2REN
 dp+Zy+8/wgb3ksQST33MxQSjOppwTawTAVfzZDG3shk5CXfM61AMFOWGjzT1vZ5C8ku4
 U1/m1jPQo8S4X+xRpPj2n0vARYFHQdoSawBEFua8I9vFjVENtNt+3+ZlpyX5NMb2jUMz
 B1AQ==
X-Gm-Message-State: AFuF++naa79ggA+1LCG6iZo4jubbFbsLeldMJLgqdVA0moZqj5/gsfKu
 CesgZT3xGyOyf0jZDsoZRyszc+UBqaD5vmnfkFjfawmtu170XQhWsql2yqnIFZb5Ggg=
X-Gm-Gg: AYBFou1kXjM1TxIJ1yimxdjpoe140ik5ZQbwDd8TAAOi4ZaCyaGFIYbXwsz7zAbpwHZ
 yA8h9oWLbaonF60/SA5klTDxnzXnEpXOyEMUFWHSpWasvMJtW8MFCxGv301nzNohRJOrxqChW8y
 q3nxE3My3blm+gUHofslSaaO1lIiy5u1qEjXKfmgIfVlw3BOL3mtdBZ8XUWh5mE+5ZX8GLCXq26
 FOpM0khSaMWNtKSjs66sqomFDKuSK5T1JfETgsVLyfhgEaCb2N9t6mudwvbO0KbsVavsG0wNR1Y
 t6FOZkOLp7sTCtCFi8R107YhKNIAcei0oiu/ToOZs4L8wR/mzMoiQ/ckapoKMBlBV0SOkjmDO1c
 FAq42QvrbqGD8Suh+m9H2DZrIAmNYO7KaxFBc3s4qnxDzSinmAwyq7RvW7zyNCPoeRU6BiIozhJ
 MvLQ5kSy6I0d2XtmqLMry7nCVpG/G4be/G8FzuBrYM80YMA8+GJvTx/4xvoZ3ZsOA6N373F4HWJ
 9XCglfAr4ytpyprwseLhp/n5x7oAw==
X-Received: by 2002:a05:6a00:1915:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-86168785ffcmr41359819b3a.11.1788888670194; 
 Tue, 08 Sep 2026 10:31:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86343e6dae6sm4316795b3a.11.2026.09.08.10.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:31:09 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:31:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH dpdk] fib: expose tbl8 usage statistics
Message-ID: <20260908103100.3bf817f5@phoenix.local>
In-Reply-To: <20260224133340.1638295-2-rjarry@redhat.com>
References: <20260224133340.1638295-2-rjarry@redhat.com>
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

On Tue, 24 Feb 2026 14:33:41 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Both dir24_8 (IPv4) and trie (IPv6) algorithms already track tbl8 group
> allocation internally but there is no way for applications to query this
> information. Monitoring tbl8 usage is important to detect exhaustion
> before route insertions start failing.
> 
> Add rte_fib_tbl8_get_stats() and rte_fib6_tbl8_get_stats() to let
> applications retrieve the number of tbl8 groups currently in use and the
> total capacity. For dir24_8, the used count comes from cur_tbl8s. For
> trie, it comes from tbl8_pool_pos which reflects the actual number of
> allocated entries since the pool is a stack.
> 
> Add unit tests for both functions covering invalid arguments, unsupported
> FIB types and verifying that the used count changes correctly after route
> insertions and deletions.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Exposing fib usage statistics is good idea but rather than returning statistics
individually as call pointers, it would be better to have new statistics
structure similar to ethdev xstats with name and value. That would allow
for expansion and be generic against table implementations.
