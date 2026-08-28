Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1207AC61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 16:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6EDC4025A;
	Fri, 28 Aug 2026 18:58:29 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id A112F40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 18:58:27 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1677529b3a.1
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787936306;
 x=1788541106; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJt5aSY+CIPOraRHRm+uAv/W6ZE91lNGglFgM0BdXP8=;
 b=CB+Sbg83ogFBVcXnDkCeX/+ChFYvCTQg5u47IWL9Esii70Iru4ZuJWnG0siyV1ONSJ
 gXSpLFrKmmZ+jnzLPC78k8rs0rz2r07rewHhBodflf9V2xr7BY1QJKHUnUnj1OryrljS
 aOjZ/6g80ISn/xDblrJW5tfXFSQbCPHJj1YDUXYE6ihi7z5um9TTySh1c3RuQxbTi7Sh
 NdZO5Jh3zO8zk5EsXgQTIumjTcg7dpx45iPvP/8tj+dDQx2Fnc58M/jvEegaLwQ3pkHp
 qm+jkLho1YIhdsnITlNhHTtCe9Fw2xZv6dGb3fugfaplEk7obaKXi1DazRSh4py02aZz
 Q/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787936306; x=1788541106;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJt5aSY+CIPOraRHRm+uAv/W6ZE91lNGglFgM0BdXP8=;
 b=NE8V0Yw3v1oznKLbkQLqh0QVEpwY2t77gbhCOJsvkFwLxLzES2/aJPUs/DwmaKuefs
 2g0w5cVChKiXI0ThGpX4lbxJBruTY4g7b4qA+3KY2qvWyO5CmQMDhtoRydKNl/fwBbJQ
 vGMHbHOw7hUOwjJLLtBXi05TlKVMY9R8QVh7V/W8tmXRlUNHPeLm+Z0Q4Dvp2/WZbh4n
 XVG9Oz4lQq4puvblyrH27/MOjrPrFlIpo5zFzVYrfJHNpj4yNlei+dlKXuYtmKuMBa9j
 zEu196Pzvw2JaCM68f87U+vGIPa49cN8KsNPtIqqQdzOPV6r6QHroycF3WaWn5xQB6UT
 /PzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoImE/En4K54HJ/A/+6JkTiDTjMWe7tgtfjv03BgFSxwis5L9Am9GfSAz/PdRbv2BvrkDA=@dpdk.org
X-Gm-Message-State: AFuF++lWl5Ed67WbFiSp1BKz88fkynAkTo7pvEXc96VU+l+2YUbUhlP9
 0/wLBShZ9NM66EbP4YrXtG3N7fQgnf7mU0J9HcRdBSkfhqyWamdAAB4GuI57LtSUaq4=
X-Gm-Gg: AR+sD12TCcsLrNdFaVV6fZ2WQCjqUyzrDHbYoQ11lplCiS29ZTunEGzFNrcfZ32E8bB
 WIhWBgeZtt6ecOrFciXGNi/kALq60ri5qLDbtBrkLyiqqeJ3/E2YdM5XyJUoCOxjZILISowXjnD
 +6P7GC7+EDlT0+rmQXR+SqYEABosDUhX0gwmx1ddDAw7bQL0KmHTba/zW/BSFVFTPEJt0yoTgAe
 f8z21kvfK+gXCV5zXPrQuhpORaPfCAVkKQmA1FWdFgIN30OK+DaccNRO4BlfyFtM1nrKuB0xLxp
 V2ShG4P9D1Q5NWdsPc+lig+M/P08q5+9Upk3wWmhTbJ9RbVDah/RhXALDSC6c3QJsSqDm6rIcoj
 CP3klA7Ve/v1nJ8xRFNKta5Hnhqa9MuHJnhUdvDW8NEpQ2LdKeLAhp0kFCCxtI369/LxYlF1ipM
 AI7kKGLzifwxmdTJFGs+5U8dGPuR6scR023VLmMHud3nJ8YwDPCBer7RU1APK2cOnZNHPV8QyaY
 D1POb7ixabHlnW6p1jGHSIuZc6xiQ==
X-Received: by 2002:a05:6a00:3019:b0:847:893f:2d0c with SMTP id
 d2e1a72fcca58-85628591d2bmr17513766b3a.5.1787936306495; 
 Fri, 28 Aug 2026 09:58:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36aecb6sm763536a12.18.2026.08.28.09.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 09:58:26 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:58:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <chengwen.feng@linux.dev>
Cc: thomas@monjalon.net, aconole@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v5] devtools: support local opencode agent for patch review
Message-ID: <20260828095818.1615d0f5@phoenix.local>
In-Reply-To: <20260807031104.2503404-1-chengwen.feng@linux.dev>
References: <20260703091902.525837-1-datshan@qq.com>
 <20260807031104.2503404-1-chengwen.feng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri,  7 Aug 2026 11:11:04 +0800
Chengwen Feng <chengwen.feng@linux.dev> wrote:

> From: Chengwen Feng <fengchengwen@huawei.com>
>=20
> Currently review-patch.py only supports cloud AI providers
> (Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.
>=20
> Add a --via option that invokes the locally installed opencode CLI as
> the review runner instead of making HTTP calls. opencode reads
> AGENTS.md from the DPDK project directory automatically, needing no
> configuration beyond opencode on PATH.
>=20
> The --via and -p/--provider options are independent -- via routes to
> the local agent mode while -p continues to use the cloud API path.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

More detailed AI review found some issues where putting this
in may expose security risks.


> +    Note: opencode runs with its default agent toolset, which includes
> +    write/edit/bash against the working tree (--dir points at the DPDK
> +    root). A review should ideally be read-only; restricting the toolset
> +    requires opencode to gain a --read-only or --agent flag, which it
> +    does not currently expose.

This premise is not correct, and the resulting exposure is the one
thing I don't want to merge as-is.

Problem
-------
The input to this tool is patches from a public mailing list, i.e.
untrusted text from strangers. In --via mode that text is fed to an
agent that holds write, edit and bash on --dir, which is the user's
DPDK tree. A patch that talks the agent into running a command gets
code execution on the maintainer's machine. webfetch is the other
half: even with writes blocked, an agent that can fetch URLs can
exfiltrate whatever it read.

A note in a function docstring is not a mitigation, and patches.rst
says nothing about it at all.

Proposed solution
-----------------
opencode does expose the needed controls, so this can be fixed rather
than documented around:

  - "opencode run --agent <name>" selects a named agent.
  - Agent permissions accept allow/ask/deny per tool, keys are matched
    as wildcard patterns, so "*" works.
  - Agent rules take precedence over the user's global opencode.json,
    so a checked-in agent is authoritative.

Suggest v6 add .opencode/agent/dpdk-review.md at the tree root:

  ---
  description: Read-only DPDK patch review
  mode: primary
  tools:
    write: false
    edit: false
    patch: false
    bash: false
    webfetch: false
  permission:
    "*": deny
    read: allow
    grep: allow
    glob: allow
    list: allow
  ---
  Review the attached patch. Do not modify any file.

and pass --agent dpdk-review in the command built by _call_opencode.

Two details matter:

  - Deny by default and allow the read set, not the reverse. Tools get
    added over time and a blocklist rots.
  - Use deny, not ask. In headless run an ask is not a boundary, it
    either blocks or gets approved depending on flags.

Please also add a post-run check that the tree is unchanged (compare
git status --porcelain before and after) and error out if it is not.
That costs nothing and catches both a misconfigured agent and any
future regression in opencode's permission handling.

This needs a minimum opencode version, documented and preferably
checked at startup. On a build where --agent is unrecognised or the
frontmatter is ignored you silently get the default toolset back, and
the failure is invisible.

patches.rst then needs one sentence: the review runs under the
read-only dpdk-review agent, patches are untrusted input, do not
override the agent permissions or pass --auto.

This is a large enough change that it needs to be made and retested by
you rather than fixed up on apply. The other v5 comments still stand.
