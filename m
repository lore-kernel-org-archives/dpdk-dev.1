Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF6CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 21:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D29DD40272;
	Tue, 13 Oct 2026 23:11:27 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0C92940269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 23:11:26 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso24364555e9.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791925885; x=1792530685; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tA5Hg5HjGsheVFGtIuH2nNF3xKouVKhM6AVh7qk8wM8=;
 b=rpQ7ss8nPXDPNMMdY/ijzfa3z4BYuOtlhesIljD0QUWR6fRy8EZGnZoM+Voqm0RqWK
 qZ8ClH3A80PaDG/K4kjmgNdiF8fSxEMAItWipZjb/d0A7Ubg6fELvX/0wxEq3rYsdVrE
 3SNmvA6tMYXI0Qk2PJymmIDG1CkS6xEYg3jgonhsShDZhsjHoj/c5BzrUTlATTudyvCl
 mEkZR34adc+I1M83GZNHTFNB7fST8d8A/kmiHyaOnsn9mLr99/cR2eU8e1s2Q9tdIIue
 go3+Vsh1v1YdJ086W/2pwcvYiLsg/0fe0xiUK0MTkYDl9MwUn3cALnfaxqDA59oN/lzn
 snXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791925885; x=1792530685;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tA5Hg5HjGsheVFGtIuH2nNF3xKouVKhM6AVh7qk8wM8=;
 b=XvYsnlYKNvDYPLlnKkWl38jfGyciDDGDyikN2Q3onQ3x2tOO2mUmu3hz6kCvNGShrT
 Y6MXx70S9uV13Gyr7BcSwlGINqZ498SrOmlNZ18Y0FmCKzokt1IDAZoNnBXioCL6vceR
 zfR3+f9pNLuXerJnnYjgUp0/XiKWd2dtp6pVUtQhaakcb6iRnAziLBb943yuBZK8rPYi
 gkFW8b9N5xp0sSwGrumTcasq3Ra/wvmpSfOtu0EQL4rmWHCeIZNzSMPdf7nfwTlY9q5e
 2l47BAexu8S8c910S0P12lxA/hQBZ8ty2rnxBCI/u2Vxlp82Cax8iYtJ2iIa06OPDvg6
 3q/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByh4XrkvsrWKFmxUDAiizRX6tZDTvhVcSP9ExbhLN5rqKuigqtHQm6th1TQy+Ioi0sOzkc=@dpdk.org
X-Gm-Message-State: AFq9FYKfa+iDB4Zg/9u2Ot8GLaugNtM0m9vtcB7UqNLIoT1Xhkc1WSTw
 WkkVkDCCNMuunx0F8jzp8zpEMZKqi1XNvyB5lFyjp/lMboKLeTnw5OVo
X-Gm-Gg: AYBFou1roz2WuiPYF2atWvFLvIXCQTJ5FA6f/f/xYDRRFolwoZkkfqeZnLSCwv7YsJN
 9p1t7B3r18dzGWT4SY8QteQayqAtSnQXMOpg8/Pu+NTrW9MoMfitbG2oDKNnzziOTccxopXQuHT
 9Jxw7dm9mqMgAo4W0Oc8BOzgopVf5FM4bp2bfXktd7j2ufmRLsLQyWju1PyJANtr3WosMkkAMRs
 xGKy33iqvOtzSlBg3+/pv073DOzMsQ7Dr9jq1LK52qRlKvcWv65Ol5HHfkSbLkdVjVnT9NNeaI9
 r9F96ZgIxCX1xOaAQAZJFe1i4Vy749cH1OnRC5pJpOvdhVjUhy7IGynwpo+/JNxdvfztQhcXJfz
 EkfGjY1RhsIQSmYEDcDIgdgIOm0zHMNhfeRI2Bb+R9digHtp6L1UJ/LSQr3/FJbF4dXzxFJou6b
 e2/OgkCBlWaao1UmXr1ccB6uPGiquKcD+TiFR3sHXK5pwqypW+2Pmcti4DG/ztuUwBAGk=
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a18e4d8bbamr241862985e9.27.1791925885233; 
 Tue, 13 Oct 2026 14:11:25 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.42.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2d352e7sm14760115e9.0.2026.10.13.14.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:11:23 -0700 (PDT)
Message-ID: <55863f64-e5c6-4661-a6af-4f06c484e9aa@gmail.com>
Date: Tue, 13 Oct 2026 22:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Marchand <david.marchand@redhat.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
 <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
 <31fc3286-242e-4104-9247-330a3d1ce217@gmail.com>
 <20261013093140.6b763438@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261013093140.6b763438@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> I am not a language lawyer, but what I read is that C11 atomic fence
> is defined to only guarantee ordering of atomic objects. Since the use
> counter is not atomic in the original code, the replacement with
> rte_atomic_thread_fence() is not the same as original asm.
>
> My patch made these atomic and that is why.
>
> Should have no impact in datapath.
>
> I will respin with better human oriented comments, I have developed
> a distaste for AI prose. Reads like a lawyer wrote it.
Just a small clarification: `use` is currently declared as atomic in 
main, so all simple reads and writes to it are seq_cst atomic (and 
simple increment is a pair of two seq_cst atomic operations).
