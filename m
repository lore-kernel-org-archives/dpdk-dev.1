Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9ECD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 22:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C61624027A;
	Wed, 17 Jun 2026 00:44:17 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE724026F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 00:44:16 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so241074c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781649855;
 x=1782254655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdS5VI3gk6V3FF/4Lr5dAdWU9ULR2jCQA+UkhljlIQ8=;
 b=DVO/GZVWLAVYM1ZMcTFDCoe93+RJYUZHlmyZQkOfYZbHic3+SYXcFkM9cl5If9GHQN
 8rF4neazStLvIpSZyJIyvHDPfKz7zX57zVnd39c9imqnJDPuxPUv1lNNo5k//ldReSSv
 /lqKgQizYMtnYighGkel7YBMRJP8GPCitY4JiYVHTO0tiQ1Bo0/79qWKI4IFBvtUMkru
 2soBIrE76Y7Mfjob8Wo91QpqK/87jh+bbZ2G1WI52zDAPKPIk+bOikjdXHk9jsHsAc4Y
 LK+UpPow9P5KkPHbk1zLfYNoBs9rkTlsYMgAUMY+pEsYjMpxK2UrZvizFJrWb5lR7gyg
 +gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649855; x=1782254655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sdS5VI3gk6V3FF/4Lr5dAdWU9ULR2jCQA+UkhljlIQ8=;
 b=gCr6BrUSyQcXl6XmOxfyCPABef6apkGwnE/DH53o0bAnNwJRR4fvq/KBBnLIO4FO5f
 l6Zte2Sgf8/7o7IQXhTIu8IbQ6LfeZkrG2uU7/UiJcCNizz2j52dW/QohhoWBUEGJz7a
 R95F9h0RbJCSPB+sMvlGvOLzhbQVdxQpOo+tredUMADdIeVPAONS8TbCScx2RS3D8lOs
 ba8T+daGRX9AxngCyY6hBH0C+3i9gCV7HmhFA9QE7NtXfxIw7sx5QCxjSe2RoMHZUsjR
 W04nIrF01wXvVs9/KvKfhFfAeFMeW+oHc0rzv9PUfchtaSDCg1t7SNTf/Ux02DVVZ0Up
 LMQw==
X-Gm-Message-State: AOJu0Yy+Ns7OmJJS1Mag3c3a13EKwdXRxwKEHBbBoMLZMndoMwm1IYk7
 VF4nj2E9DNXgtCC9lBdPTsMibWNz7q/GcQcM+PtrdyrsHo0Bu4P0FMBNsyIseCi3Yeg=
X-Gm-Gg: Acq92OHbRJeSDMt3ntYkeYFgk1E8G6kuy4rySraYoqiZkfhBTTAWs3ooFKYGxd/+80Y
 KU/CuOhZymNCjjlBnk6XDovpv5AOUNyNA7xDBIcpnLzMUk09gFSyiuEusRdVS5A5sQI/5W54qAZ
 M2/7H85JP3IaIGvY/xxbTGK3JXYyk6kCoLaIdUeXlrsle5o3P4HTaXzU+un7EwSfT5ydxk/KAn5
 /+JvDdCpGXAPSSukAVH+SMUwxIUGQn018qj6rd7djgbTzX/Q0N4/6Gn+O7u87xiHsy4worOwHYu
 /CHMuxxQdHEtczesYp+93p+vG9LWVjWoxluej9622v3RQvgzk1RIdozZeBD7VM91yTeNkkR4Uiq
 XPluP6StpcvkGA98KRzNu07tGwDiMPljr66D6VzNAaEHAsqa7/Szxucyi6NLjgy01kiGc/tGZuJ
 xsF0cvAISSukUb4ayVoabgb6OY9VvSpwCM7KDsO/ULcri3zToO15i2bhJox9gUxKv87LT87QwMZ
 tk=
X-Received: by 2002:a05:7022:50a:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-1398f6f3a77mr487177c88.38.1781649855169; 
 Tue, 16 Jun 2026 15:44:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b964853sm14739455c88.11.2026.06.16.15.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 15:44:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:44:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v2] devtools: add Vertex AI to review scripts
Message-ID: <20260616154411.6b9fd576@phoenix.local>
In-Reply-To: <20260602064406.1230601-1-david.marchand@redhat.com>
References: <20260601132402.1125588-1-david.marchand@redhat.com>
 <20260602064406.1230601-1-david.marchand@redhat.com>
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

On Tue,  2 Jun 2026 08:44:06 +0200
David Marchand <david.marchand@redhat.com> wrote:

> OpenAI, xAI) can now use Vertex AI with Application Default Credentials.
> 
> This requires a python dependency google-auth but it is left as
> optional.
> 
> Key features:
> - Auto-detection of authentication method based on environment
> - Manual override via --auth flag (auto, direct, vertex)
> - Automatic model name translation for Vertex format
> - Support for both global and regional Vertex endpoints
> - Proper error handling for Vertex API responses
> 
> Provider-specific implementations:
> - Anthropic: Uses /publishers/anthropic/models/{model}:rawPredict
>   with model name format claude-sonnet-4-5@20250929
> - Google: Uses /publishers/google/models/{model}:generateContent
> - OpenAI/xAI: Use /endpoints/openapi/chat/completions
>   with publisher prefix (e.g., openai/gpt-oss-120b-maas)
> 
> Authentication detection logic:
> - Vertex: Requires google-auth library and ADC configured
> - Direct: Falls back to API key from environment variables
> 
> Available models on Vertex AI:
> - Anthropic: All Claude models
> - Google: All Gemini models
> - OpenAI: gpt-oss-120b-maas, gpt-oss-20b-maas (open-weight only)
> - xAI: grok-4.20-*, grok-4.1-fast-* variants
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

I have no direct knowledge of Vertex pro/con.
AI review with better model had some insights.

On the whole the refactor is sound: moving "model" insertion into
_build_request_meta and threading an auth string instead of api_key is
consistent across _common.py, review-patch.py and review-doc.py, and the
build_*_request signature changes match their only callers. Two issues and
a couple of minor notes.

Warning: project-id resolution is split and the early error is unreachable-
proof in the wrong direction.

  get_vertex_credentials() does:

      credentials, project = google_auth_default()
      ...
      if not project:
          error("Could not detect GCP project. Set GOOGLE_CLOUD_PROJECT ...")
      return credentials.token, project

  but the caller then applies its own fallback:

      access_token, project_id = get_vertex_credentials()
      project_id = os.environ.get("GOOGLE_CLOUD_PROJECT") \
                   or os.environ.get("GCP_PROJECT") or project_id

  If ADC resolves no project, get_vertex_credentials() calls error() and
  exits before the GCP_PROJECT fallback can run. google.auth.default()
  honors GOOGLE_CLOUD_PROJECT itself, but not GCP_PROJECT, so the
  GCP_PROJECT branch here is dead in exactly the case it exists for, and
  the error message tells the user to set a variable that wouldn't have
  helped. Resolve the project in one place: drop the "if not project"
  error from get_vertex_credentials() and check after the env fallback,
  or move the env lookups into get_vertex_credentials().

Warning: several added lines exceed the 100-column limit.

      _common.py: error("Could not detect GCP project...")        137 cols
      _common.py: error("Vertex AI support requires...")          108 cols
      _common.py: project_id = os.environ.get(...) or ...         102 cols
      _common.py: vertex_base = f"https://aiplatform..."          104 cols
      _common.py: vertex_base = f"https://{location}-..."         115 cols

  pycodestyle/flake8 will flag all five; the project_id line is also
  black-splittable so "black --check" fails on it. Wrap the f-strings and
  split the message strings.

Info: detect_auth_method() catches bare Exception around
google_auth_default(). Acceptable for best-effort autodetection, but
narrowing it (or a "# noqa"/pylint disable with a reason) documents intent.

Info: the HTTPError path now does error_data[0].get('error', ...) after
unwrapping a list. If a Vertex error body is a list of non-dicts this
raises AttributeError outside the JSONDecodeError guard. Low risk, but a
type check would harden it.

Info: --auth is wired into review-patch.py and review-doc.py but
compare-patch-reviews.sh has no passthrough, so Vertex can't be selected
when comparing providers. May be intentional for this patch.
