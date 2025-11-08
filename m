Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA9CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 01:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3987040431;
	Sat,  8 Nov 2025 02:16:57 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 21A0F402D7
 for <dev@dpdk.org>; Sat,  8 Nov 2025 02:16:56 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so1174893a12.2
 for <dev@dpdk.org>; Fri, 07 Nov 2025 17:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762564615;
 x=1763169415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV1NDFK65fKdFmiYZjXifO2vbzGio6Eft4wV0/Eliq8=;
 b=YmwN54Ml881aU4S6dRvfEENHGA5xUFL3G78C3q+BQ77YL/7T1mVlhfr9dWSKqNFJ8O
 f8N2iDTkU1HupqJhz/hnn5wwo6/fHRFZegr7rc20OfmiuWpjBZviVb2GoiQOiJsZBq+S
 g+OS9RxTf52HKo68y5m29wrY7a3F+eCokptFi6TCubTuFDIRNKfWGJ5w+xJmq8s6rCUK
 GZHc62Ec4QVQasC67fV2+Xon2OVxioLao6sCNlSWfvZOxD9yUxgr/pFXqV9eE+i0+gdv
 +Ef63pqULF3EtRw/CSfp7kffDdpKq4ZGy33MJyjshmc/H9wMX27EeTyXKRvcjR5SCWQk
 0aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762564615; x=1763169415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xV1NDFK65fKdFmiYZjXifO2vbzGio6Eft4wV0/Eliq8=;
 b=n1OQubkA7Bdy+O06G5T170Wv6D4U36O0I6oeBgvyekCtVqWkByaR56DoFVXWenVfoP
 OGgPRFYJ/uuKK/wmnm3Fc9jeYVFHekY8I71M5RLASy9gh0xPq/UePDKs27xhAJd2MEw3
 SYGZWkiYereVWLy9ACDIf1AxUUaCnD2jIBs+rn672ttGtgtBG2yN5qwOxEszGmkuBRfe
 nTPG8AXnzaCQ6RmjVNISJsKsyRKE+Tcb2oIgAS6xJuZ/gzA0wsLYsxT0mYURoYQXMXTY
 UDxF90OgXwXtWU4fWN3ROoWoL05MiUlqsSaskz/RGJAQC7P9QckmdsuXJaokWiOjFLYZ
 XC4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6D4Rc/aYfmmwPxbm7oL3PBzuw0HDdIRL4xmJeqOH8PO4puEzaO0jbPoP3gGDjKlYI1v0=@dpdk.org
X-Gm-Message-State: AOJu0YwOBnLkgjIo3ELRVVCNhDYbrYcAlOqkDGZdFqHSZYm5whkZyZEG
 FVjYM/VK+/6i2QWeNKMifjLp9XM3+C9Is5/5l8n9H9XaSixE1Z4tX9bBKnKT/Y6iTSg=
X-Gm-Gg: ASbGncsu/EYX16PpFACTrG/0mQhAlwrTCUXKfQdoRzx06fGz9T/GFWq5vu2n6nui38B
 wZPJTr744b4ITNoDiOaEwJr5SYxa04FqmenfoHm2mVDzHuSJokkIcexr9kj61PKbp0OBQoF32/l
 zV3uLbQMA7sajUFj76xlfNuaYhaVULntnkn8lrQ2ctm6l2itgoeQKhl6NnqnceMgyWMuw3Ovfk1
 uPKlV3WkTuNnYSbfBOGEY/46mHF/1fTa5+AUiVgf8HWNBeVA8dFUF7miFQ+CoSuPWomzSpd81Qk
 4dMwxW68WANqR5a8BtvxEZfBIcMWDIBuwWWoDg8EGBpp1R7LpmboBQ7REGjRiPTvDpsILAAZTx/
 7ux83HUW7XdiI7zjv5FcfT1FD0MwGXiv4NXIsmFUp+wGLhJd5XrbMdkXYh75hn2nyj6vsQG9xad
 NjMUIWby9TNJryhUuS8Zi7wb6+hAzf2378mVxlm7wPFZIgiBpL2pDbngM=
X-Google-Smtp-Source: AGHT+IFZE9e5GXa841JojwR9Oa8snUa9sXMeZKtQqr0jMTfLCBsyHJRanxj+ZR3q3PsbhTdd/fkpkA==
X-Received: by 2002:a17:90b:4c8a:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-3436cd06e77mr1366903a91.32.1762564615219; 
 Fri, 07 Nov 2025 17:16:55 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341d0b47ee3sm3992031a91.2.2025.11.07.17.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 17:16:55 -0800 (PST)
Date: Fri, 7 Nov 2025 17:09:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Message-ID: <20251107170859.0f618ab2@phoenix>
In-Reply-To: <2fd10b3a010f495b82cbbcfef29dd9df@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-4-stephen@networkplumber.org>
 <2951855794674cada3b9ab9574699917@huawei.com>
 <2fd10b3a010f495b82cbbcfef29dd9df@huawei.com>
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

On Fri, 7 Nov 2025 17:45:51 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> P.S. When running with UB sanitizer:
> 
> RTE>>bpf_elf_load_autotest  
> BPF: resolve_xsym(40): EBPF_PSEUDO_CALL to external function: dummy_func1
> ../../src/lib/bpf/bpf_validate.c:247:24: runtime error: signed integer overflow: 9223372036854775807 + 2147483647 cannot be represented in type 'long int'
>     #0 0x2b1fdca in eval_add ../../src/lib/bpf/bpf_validate.c:247
>     #1 0x2b2b9dc in eval_alu ../../src/lib/bpf/bpf_validate.c:691
>     #2 0x2b3b187 in evaluate ../../src/lib/bpf/bpf_validate.c:2446
>     #3 0x2b3bf0f in __rte_bpf_validate ../../src/lib/bpf/bpf_validate.c:2537
>     #4 0x2b19b33 in rte_bpf_load ../../src/lib/bpf/bpf_load.c:113
>     #5 0x2b47d6d in bpf_load_elf ../../src/lib/bpf/bpf_load_elf.c:288
>     #6 0x2b47fe8 in rte_bpf_elf_load ../../src/lib/bpf/bpf_load_elf.c:320
>     #7 0x66b4b8 in test_bpf_elf_load ../../src/app/test/test_bpf.c:3382

Hmm. looks like a pre-existing BPF library bug since this code was never
tested before.
