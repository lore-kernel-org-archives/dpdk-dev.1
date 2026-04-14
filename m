Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB19F9D0F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 20:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 897754028F;
	Tue, 14 Apr 2026 22:06:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A8F3D4028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776197181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRc1CxqlAoE6nBL3s2e2EbnZHrGt/M2mr2PT9lDVvVA=;
 b=RItnoVymYzIjUkwn1kjaHQeF2+vq50OxT1PNK3+3yYVUrWrflDWyOjUA0HV3/GFj97HOG1
 l/RsUeW7tqNbv/poZKGk7kWuVnXuTZbrCvuJ/3o2iHps+OLDzBU9FFlE2s0YDJXg6ywP0E
 GK3TOoEmEXedoZekSWjPm4AtLFMsL4E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-MrqInOO4MDKMn16ENkZWZg-1; Tue,
 14 Apr 2026 16:06:17 -0400
X-MC-Unique: MrqInOO4MDKMn16ENkZWZg-1
X-Mimecast-MFC-AGG-ID: MrqInOO4MDKMn16ENkZWZg_1776197177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD7F41956056; Tue, 14 Apr 2026 20:06:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F05719560B1; Tue, 14 Apr 2026 20:06:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 5/6] doc: add AI-assisted patch review to
 contributing guide
In-Reply-To: <20260402194618.134002-6-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Thu, 2 Apr 2026 12:44:35 -0700")
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-6-stephen@networkplumber.org>
Date: Tue, 14 Apr 2026 16:06:14 -0400
Message-ID: <f7tse8x8fyh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dydvtTKA_LilLXWTJeXDs954VP59kGZkhrIlSviwDlI_1776197177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> Add a new section to the contributing guide describing the
> analyze-patch.py script which uses AI providers to review patches
> against DPDK coding standards before submission to the mailing list.
>
> The new section covers basic usage, provider selection, patch series
> handling, LTS release review, and output format options. A note
> clarifies that AI review supplements but does not replace human
> review.
>
> Also add a reference to the script in the new driver guide's
> test tools checklist.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

>  doc/guides/contributing/new_driver.rst |  2 +
>  doc/guides/contributing/patches.rst    | 59 ++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/doc/guides/contributing/new_driver.rst b/doc/guides/contributing/new_driver.rst
> index 555e875329..6c0d356cfd 100644
> --- a/doc/guides/contributing/new_driver.rst
> +++ b/doc/guides/contributing/new_driver.rst
> @@ -210,3 +210,5 @@ Be sure to run the following test tools per patch in a patch series:
>  * `check-doc-vs-code.sh`
>  * `check-spdx-tag.sh`
>  * Build documentation and validate how output looks
> +* Optionally run ``analyze-patch.py`` for AI-assisted review
> +  (see :ref:`ai_assisted_review` in the Contributing Guide)
> diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
> index 5f554d47e6..1e50799c19 100644
> --- a/doc/guides/contributing/patches.rst
> +++ b/doc/guides/contributing/patches.rst
> @@ -183,6 +183,10 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
>  
>  * Code and related documentation must be updated atomically in the same patch.
>  
> +* Consider running the :ref:`AI-assisted review <ai_assisted_review>` tool
> +  before submitting to catch common issues early.
> +  This is encouraged but not required.
> +
>  Once the changes have been made you should commit them to your local repo.
>  
>  For small changes, that do not require specific explanations, it is better to keep things together in the
> @@ -503,6 +507,61 @@ Additionally, when contributing to the DTS tool, patches should also be checked
>  the ``dts-check-format.sh`` script in the ``devtools`` directory of the DPDK repo.
>  To run the script, extra :ref:`Python dependencies <dts_deps>` are needed.
>  
> +
> +.. _ai_assisted_review:
> +
> +AI-Assisted Patch Review
> +------------------------
> +
> +Contributors may optionally use the ``devtools/analyze-patch.py`` script
> +to get an AI-assisted review of patches before submitting them to the mailing list.
> +The script checks patches against the DPDK coding standards and contribution
> +guidelines documented in ``AGENTS.md``.
> +
> +The script supports multiple AI providers (Anthropic Claude, OpenAI ChatGPT,
> +xAI Grok, Google Gemini).  An API key for the chosen provider must be set
> +in the corresponding environment variable (see ``--list-providers``).
> +
> +Basic usage::
> +
> +   # Review a single patch (default provider: Anthropic Claude)
> +   devtools/analyze-patch.py my-patch.patch
> +
> +   # Use a different provider
> +   devtools/analyze-patch.py -p openai my-patch.patch
> +
> +   # Review for an LTS branch (enables stricter rules)
> +   devtools/analyze-patch.py -r 24.11 my-patch.patch
> +
> +   # List available providers and their API key variables
> +   devtools/analyze-patch.py --list-providers
> +
> +For a patch series in an mbox file, the ``--split-patches`` option reviews
> +each patch individually::
> +
> +   devtools/analyze-patch.py --split-patches series.mbox
> +
> +   # Review only a range of patches
> +   devtools/analyze-patch.py --split-patches --patch-range 1-5 series.mbox
> +
> +When reviewing for a Long Term Stable (LTS) release, use the ``-r`` option
> +with the target version.  Any DPDK release with minor version ``.11``
> +(e.g., 23.11, 24.11) is automatically recognized as LTS,
> +and the script will enforce stricter rules: bug fixes only, no new features or APIs.
> +
> +Output can be formatted as plain text (default), Markdown, HTML, or JSON::
> +
> +   devtools/analyze-patch.py -f markdown -o review.md my-patch.patch
> +
> +The review guidelines in ``AGENTS.md`` focus on correctness bug detection
> +and other DPDK-specific requirements. Commit message formatting and
> +SPDX/copyright compliance are checked by ``checkpatches.sh`` and are
> +not duplicated in the AI review.
> +
> +.. note::
> +
> +   Always verify AI suggestions before acting on them.
> +
>  .. _contrib_check_compilation:
>  
>  Checking Compilation

